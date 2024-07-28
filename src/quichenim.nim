# Nim port of the quiche example client, to validate that things actually work

import ./quichenim/[ffi, config, packet, connection, logging]

import std/[posix, nativesockets, asyncdispatch, asyncnet, sysrand, cmdline, strutils]

const MAX_DATAGRAM_SIZE = 1350
const LOCAL_CONN_ID_LEN = 16

type
  ConnIO = object
    conn: QuicheConnection
    sock: AsyncSocket
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
    sock = newAsyncSocket(Domain(peer.ai_family), SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP) 
    scid = genConnectionId()
  
  var
    localAddr: Sockaddr_in
    localAddrLen: SockLen

  sock.bindAddr()

  localAddr.sin_family = TSa_Family(peer.ai_family)
  localAddrLen = sizeof(localAddr).SockLen
  
  if getsockname(sock.getFd(), cast[ptr SockAddr](localAddr.addr), localAddrLen.addr) != cint(0):
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

proc bufToStr(b: openArray[byte]): string =
  var s = newString(b.len)
  copyMem(s[0].addr, b[0].unsafeAddr, b.len)
  s

proc sendHandshake(c: ConnIO) {.async.} =
  var
    buf: array[0..MAX_DATAGRAM_SIZE, byte]
    info: SendInfo
  
  let 
    res = c.conn.send(buf, info)
    size = res.expect("failed to prepare handshake packet")

  await c.sock.sendTo(c.peerHost, c.peerPort, bufToStr(buf))
  
proc readAvailablePackets(c: ConnIO) {.async.} =
  discard ""

proc run(c: ConnIO) {.async.} =
  await c.sendHandshake()

  while true:
    var timeout = int(c.conn.timeout_as_millis())
    var readSuccess = await withTimeout(c.readAvailablePackets(), timeout)
    if not readSuccess:
      # TODO: raise error instead?
      echo "read timeout"
      break


proc parseArgs(): tuple[host: string, port: Port] =
  if paramCount() < 2:
    echo "usage: quichenim <host> <port>"
    system.quit(1)
  let 
    host = paramStr(1)
    port = paramStr(2).parseInt()
  (host, Port(port))

when isMainModule:
  let (host, port) = parseArgs()
  
  echo "quiche version: ", $quiche_version()
  discard quiche_debug_log(debugLog)
  let cfg = makeConfig()

  let conn = prepareConnection(cfg, host, port)
  echo "conn: " & $conn



