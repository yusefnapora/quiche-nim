# Nim port of the quiche example client, to validate that things actually work

import ./quichenim/[ffi, config, packet, connection, logging]

import std/[os, posix, net, nativesockets, asyncdispatch, sysrand, cmdline, strutils, uri, strformat]

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

func makeConfig(): QuicheConfig =
  let cfg = newQuicheConfig(0xbabababa)
  cfg.set_application_protos("\x0ahq-interop\x05hq-29\x05hq-28\x05hq-27\x08http/0.9")
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
  
  if getsockname(sock.SocketHandle, cast[ptr SockAddr](localAddr.addr), localAddrLen.addr) != cint(0):
    raise newException(Exception, "unable to get local socket address")
  
  # FIXME: don't assume Sockaddr_in (could be ipv6)
  let 
    localAddrIn = cast[Sockaddr_in](localAddr)
    localAddrStr = getAddrString(cast[ptr SockAddr](localAddr.addr))
    localPort = localAddrIn.sin_port
  debugLog &"got local socket addr: {localAddrStr}:{$localPort}"
  let conn = connection.connect(host, scid, cast[ptr SockAddr](localAddr.addr), localAddrLen, peer.ai_addr, peer.ai_addrlen, cfg)

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
  

proc eventLoop(c: ConnIO, url: Uri) =
  var sentRequest: bool = false

  # send initial handshake packet
  c.sendLoop()

  while true:
    var shouldRead = true
    try:
      poll(c.conn.timeout_as_millis().int)
    except ValueError:
      # If the event loop reported no events, it means that the timeout
      # has expired, so handle it without attempting to read packets. We
      # will then proceed with the send loop.
      # echo "timed out"
      c.conn.on_timeout()
      # shouldRead = false
    
    if shouldRead:
      c.readLoop()
      debugLog "Done reading"

    if c.conn.is_established() and not sentRequest:
      debugLog "initial handshake complete"
      debugLog &"sending http request to URI: {$url}"
      let req = "GET " & $url.path & "\r\n"
      var sendErrorCode: uint64
      let sent = c.conn.stream_send(HTTP_REQ_STREAM_ID, cast[seq[byte]](req), true, sendErrorCode).expect("stream send failed")
      debugLog &"queued up {sent} bytes to send on http stream"
      sentRequest = true
      break


    for s in c.conn.readable():
      # TODO: read from each incoming stream and pipe to console
      discard
    
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


