# Nim port of the quiche example client, to validate that things actually work

import ./quichenim/[ffi, config, packet, connection, logging]

import std/[os, posix, net, nativesockets, asyncdispatch, sysrand, cmdline, strutils, uri, strformat, options]

const MAX_DATAGRAM_SIZE = 1350
const LOCAL_CONN_ID_LEN = 16
const HTTP_REQ_STREAM_ID = uint64(4)

type
  ConnIO = object
    conn: QuicheConnection
    sock: AsyncFD
    peerAddr: ptr AddrInfo
    peerHost: string
    peerPort: Port
    localAddr: Sockaddr_storage
    localAddrLen: SockLen

proc `=destroy`(c: ConnIO) =
  if c.peerAddr != nil:
    freeAddrInfo(c.peerAddr)

proc debugLog(line: string, origin: string = "client") =
  stderr.writeLine &"[{origin}]: {line}\n"

proc echoBytes(bytes: openArray[byte]) =
  let s = newString(bytes.len)
  copyMem(s[0].addr, bytes[0].unsafeAddr, bytes.len)
  echo s

proc getPort(sockAddr: ptr SockAddr): int =
  case sockAddr.sa_family:
  of Domain.AF_INET.uint8:
    let a = cast[ptr Sockaddr_in](sockAddr)
    a.sin_port.int
  of Domain.AF_INET6.uint8:
    let a = cast[ptr Sockaddr_in6](sockAddr)
    a.sin6_port.int
  else:
    raise newException(ValueError, &"unsupported address family {sockAddr.sa_family}")

proc `$`(sockAddr: ptr SockAddr): string = 
  let
    port = getPort(sockAddr)
    host = getAddrString(sockAddr)
  &"{host}:{port}"

func makeConfig(): QuicheConfig =
  let cfg = newQuicheConfig(QUICHE_PROTOCOL_VERSION)
  cfg.set_application_protos("hq-interop", "hq-29", "hq-28", "hq-27", "http/0.9")
    .expect("unable to set application protocols")

  cfg.set_max_idle_timeout(5000)
  cfg.set_max_recv_udp_payload_size(MAX_DATAGRAM_SIZE)
  cfg.set_max_send_udp_payload_size(MAX_DATAGRAM_SIZE)
  cfg.set_initial_max_data(10000000)
  cfg.set_initial_max_stream_data_bidi_local(1000000)
  cfg.set_initial_max_stream_data_uni(1000000)
  cfg.set_initial_max_streams_bidi(100)
  cfg.set_initial_max_streams_uni(100)
  cfg.set_disable_active_migration(true)
  cfg.verify_peer(false) # Don't do this in production!
  cfg

## generates a local connection id
proc genConnectionId(): seq[uint8] =
  urandom(LOCAL_CONN_ID_LEN)


proc prepareConnection(cfg: QuicheConfig, host: string, port: Port): ConnIO =
  let 
    peer = getAddrInfo(host, port, Domain.AF_UNSPEC, SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP)
    sock = createAsyncNativeSocket(Domain(peer.ai_family), SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP) 
    scid = genConnectionId()
  
  if connect(sock.SocketHandle, peer.ai_addr, peer.ai_addrlen) != cint(0):
    raise newException(Exception, &"unable to connect to peer socket: {osLastError()}")

  var
    localAddr: Sockaddr_storage
    localAddrLen: SockLen

  localAddr.ss_family = TSa_Family(peer.ai_family)
  localAddrLen = sizeof(localAddr).SockLen
  let localAddrPtr = cast[ptr SockAddr](localAddr.addr)
  
  if getsockname(sock.SocketHandle, localAddrPtr, localAddrLen.addr) != cint(0):
    raise newException(Exception, "unable to get local socket address")
   
  debugLog &"got local socket addr: {$localAddrPtr}"
  let conn = connection.connect(host, scid, localAddrPtr, localAddrLen, peer.ai_addr, peer.ai_addrlen, cfg)

  ConnIO(
    conn: conn,
    sock: sock,
    peerAddr: peer,
    peerHost: host,
    peerPort: port,
    localAddr: localAddr, 
    localAddrLen: localAddrLen)

proc readLoop(c: ConnIO) =
  var 
    buf: array[0..MAX_DATAGRAM_SIZE, byte]
    fromAddr: Sockaddr_storage
    fromLen: SockLen

  let flags = {SocketFlag.SafeDisconn} 
  while true:
    let res = recvfrom(c.sock.SocketHandle, buf[0].addr, buf.len.cint, flags.toOsFlags(),
      nil, nil)
    if res < 0:
      let lastError = osLastError()

      # if no data available, break out of the read loop
      if lastError.int32 == EINTR or lastError.int32 == EWOULDBLOCK or lastError.int32 == EAGAIN:
        break
      else:
        raise newException(Exception, "read failed")

    let 
      recvInfo = RecvInfo(
        from_addr: c.peerAddr.ai_addr, 
        from_len: c.peerAddr.ai_addrlen,
        to_addr: cast[ptr SockAddr](c.localAddr.addr),
        to_len: c.localAddrLen)
      packet = buf[0..(res-1)]


    let len = c.conn.recv(packet, recvInfo).expect("read failed")
    debugLog &"quiche processed packet with len: {len}" 

## Generate outgoing QUIC packets & send them on the socket,
## until quiche reports there are no more to send
proc sendLoop(c: ConnIO) =
  var
    buf: array[0..MAX_DATAGRAM_SIZE, byte]
    info: SendInfo
  
  while true:
    let res = c.conn.send(buf, info)
    if res.isErr:
      let e = res.error()
      if e == QuicheError.Done:
        return
      debugLog "send failed: " & $e
      # c.conn.close(app: false, 1, "fail")
    let 
      len = res.get()
      packet = buf[0..(len-1)]
      size = sendto(c.sock.SocketHandle, packet[0].addr, packet.len, MSG_NOSIGNAL, 
        nil, 0)
      packetInfo = get_header_info(packet, LOCAL_CONN_ID_LEN)

    debugLog &"outgoing len: {len}"
    if packetInfo.isErr:
      debugLog &"error getting header info from outgoing packet: {packetInfo.error()}"
    else:
      debugLog &"outgoing packet info: {packetInfo.get()}"

    if size < 0:
      let lastError = osLastError()

      # if sending would block, break out of the send loop
      if lastError.int32 == EINTR or lastError.int32 == EWOULDBLOCK or lastError.int32 == EAGAIN:
        break
      else:
        raise newException(Exception, &"send failed: {lastError}")

    debugLog &"sent {$size} bytes on socket"
  
## Reads data from all readable streams and dumps to stdout
## Returns true if we're finished reading all HTTP data
proc readAllStreams(c: ConnIO): bool =
  var
    buf: array[0..65535, byte]
    fin: bool
    errorCode: uint64

  for streamId in c.conn.readable():
    debugLog &"reading from stream {streamId}"
    let res = c.conn.stream_recv(streamId, buf, fin, errorCode)
    if res.isErr:
      debugLog &"stream read error: {res.error()} (error code: {errorCode})"
      continue
    let 
      len = res.get()
      streamBuf = buf[0..(len-1)]
    debugLog &"stream {streamId} has {len} bytes"
    echoBytes streamBuf

    if streamId == HTTP_REQ_STREAM_ID and fin:
      return true

  false

proc eventLoop(c: ConnIO, url: Uri) =
  var sentRequest: bool = false

  # send initial handshake packet
  c.sendLoop()

  while true:
    try:
      poll(c.conn.timeout_as_millis().int)
    except ValueError:
      # If the event loop reported no events, it means that the timeout
      # has expired, so we inform quiche
      c.conn.on_timeout()
    
    c.readLoop()
    # debugLog "Done reading"

    if c.conn.is_established() and not sentRequest:
      debugLog "initial handshake complete"
      debugLog &"sending http request to URI: {$url}"
      let req = "GET " & $url.path & "\r\n"
      var sendErrorCode: uint64
      let sent = c.conn.stream_send(HTTP_REQ_STREAM_ID, cast[seq[byte]](req), true, sendErrorCode).expect("stream send failed")
      debugLog &"queued up {sent} bytes to send on http stream"
      sentRequest = true

    # read available data from all QUIC streams
    let shouldClose = c.readAllStreams()
    if shouldClose:
      # TODO: close the connection to be polite
      break
    
    # send any outgoing packets
    c.sendLoop()

    if c.conn.is_closed():
      debugLog "connection closed"
      break

proc parseArgs(): tuple[uri: Uri, host: string, port: Port] =
  if paramCount() < 1:
    debugLog "usage: quichenim <url>"
    system.quit(1)
  let 
    url = parseUri(paramStr(1))
    host = string(url.hostname)
    port = string(url.port).parseInt().Port

  (url, host, port)

when isMainModule:
  let (url, host, port) = parseArgs()
  
  debugLog "quiche version: " & $quiche_version()
  discard quiche_debug_log(proc (line: string) = debugLog(line, "quiche"))
  let cfg = makeConfig()

  let conn = prepareConnection(cfg, host, port)
  debugLog "starting event loop"
  conn.eventLoop(url)


