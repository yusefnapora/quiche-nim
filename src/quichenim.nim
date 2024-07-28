# Nim port of the quiche example client, to validate that things actually work

import ./quichenim/[ffi, config, packet, connection, logging]

import std/[posix, nativesockets, asyncdispatch, sysrand, cmdline, strutils, uri]

const MAX_DATAGRAM_SIZE = 1350
const LOCAL_CONN_ID_LEN = 16
const HTTP_REQ_STREAM_ID = uint64(4);

type
  ConnIO = object
    conn: QuicheConnection
    sock: AsyncFD
    peerAddr: ptr AddrInfo
    peerHost: string
    peerPort: Port
    localAddr: Sockaddr_in
    localAddrLen: SockLen

proc `=destroy`(c: ConnIO) =
  if c.peerAddr != nil:
    freeAddrInfo(c.peerAddr)

proc debugLog(line: string) =
  echo "[quiche]: " & line

func makeConfig(): QuicheConfig =
  let cfg = newQuicheConfig(QUICHE_PROTOCOL_VERSION)
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
  cfg

proc genConnectionId(): seq[uint8] =
  urandom(LOCAL_CONN_ID_LEN)

proc prepareConnection(cfg: QuicheConfig, host: string, port: Port): ConnIO =
  let 
    peer = getAddrInfo(host, port, Domain.AF_UNSPEC, SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP)
    sock = createAsyncNativeSocket(Domain(peer.ai_family), SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP) 
    scid = genConnectionId()
  
  var
    localAddr: Sockaddr_in
    localAddrLen: SockLen

  localAddr.sin_family = TSa_Family(peer.ai_family)
  localAddrLen = sizeof(localAddr).SockLen
  
  if getsockname(sock.SocketHandle, cast[ptr SockAddr](localAddr.addr), localAddrLen.addr) != cint(0):
    raise newException(Exception, "unable to get local socket address")

  echo "got local socket addr: " &  getAddrString(cast[ptr SockAddr](localAddr.addr))
  let conn = connection.connect(host, scid, cast[ptr SockAddr](localAddr.addr), localAddrLen, peer.ai_addr, SockLen(peer.ai_addrlen), cfg)

  ConnIO(
    conn: conn,
    sock: sock,
    peerAddr: peer,
    peerHost: host,
    peerPort: port,
    localAddr: localAddr, 
    localAddrLen: localAddrLen)

## Generate outgoing QUIC packets & send them on the socket,
## until quiche reports there are no more to send
proc sendOutgoing(c: ConnIO) {.async.} =
  var
    buf: array[0..MAX_DATAGRAM_SIZE, byte]
    info: SendInfo
  
  while true:
    let res = c.conn.send(buf, info)
    if res.isErr:
      let e = res.error()
      if e == QuicheError.Done:
        return
      echo "send failed: " & $e
      # c.conn.close(app: false, 1, "fail")
    let len = res.get()

    await c.sock.sendTo(buf.addr, int(len), c.peerAddr.ai_addr, c.peerAddr.ai_addrlen.SockLen)
  
proc processNextIncoming(c: ConnIO) {.async.} =
  var 
    buf: array[0..MAX_DATAGRAM_SIZE, byte]
    fromAddr: Sockaddr_storage
    fromAddrLen: SockLen

  fromAddrLen = sizeof(fromAddr).SockLen

  let packetLen = await c.sock.recvFromInto(buf.addr, buf.len, cast[ptr SockAddr](fromAddr.addr), fromAddrLen.addr)
  echo "read packet from socket with len: " & $packetLen

  let recvInfo = RecvInfo(from_addr: 
    cast[ptr SockAddr](fromAddr.addr), 
    from_len: fromAddrLen,
    to_addr: cast[ptr SockAddr](c.localAddr.addr),
    to_len: c.localAddrLen)

  let readRes = c.conn.recv(buf, recvInfo)
  let len = readRes.expect("read failed")
  echo "quiche processed packet with len: " & $len

proc processAllIncoming(c: ConnIO): Future[int] {.async.} =
  var count = 0
  while true:
    var timeout = int(c.conn.timeout_as_millis())
    var readSuccess = await withTimeout(c.processNextIncoming(), timeout)
    if not readSuccess:
      c.conn.on_timeout()
      break
    count += 1
  count

proc run(c: ConnIO, url: Uri) {.async.} =
  await c.sendOutgoing()
  echo "sent initial packet"

  var n = await c.processAllIncoming()
  echo "processed " & $n & " packets"

  if c.conn.is_closed():
    echo "connection closed"
    return

  echo "initial handshake complete"
  echo "sending http request to URI: " & $url
  let req = "GET " & $url.path & "\r\n"
  var sendErrorCode: uint64
  let sent = c.conn.stream_send(HTTP_REQ_STREAM_ID, cast[seq[byte]](req), true, sendErrorCode).expect("stream send failed")

  await c.sendOutgoing()
  echo "sent http request"


proc parseArgs(): tuple[uri: Uri, host: string, port: Port] =
  if paramCount() < 1:
    echo "usage: quichenim <url>"
    system.quit(1)
  let 
    url = parseUri(paramStr(1))
    host = string(url.hostname)
    port = string(url.port).parseInt().Port

  (url, host, port)

when isMainModule:
  let (url, host, port) = parseArgs()
  
  echo "quiche version: ", $quiche_version()
  discard quiche_debug_log(debugLog)
  let cfg = makeConfig()

  let conn = prepareConnection(cfg, host, port)
  echo "starting event loop"
  waitFor conn.run(url)


