# Nim port of the quiche example client, to validate that things actually work

import quichenim/ffi
import quichenim/config
import quichenim/packet
import quichenim/connection

import std/posix
import std/nativesockets
import std/asyncnet
import std/sysrand

const MAX_DATAGRAM_SIZE = 1350
const LOCAL_CONN_ID_LEN = 16

type
  ConnIO = object
    peerAddr: ptr AddrInfo
    conn: QuicheConnection


proc `=destroy`(c: ConnIO) =
  if c.peerAddr != nil:
    freeAddrInfo(c.peerAddr)

proc debugLog(line: cstring, arg: pointer) {. cdecl .} =
  echo "[quiche]: " & $line

proc makeConfig(): QuicheConfig =
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

proc connectPeer(cfg: QuicheConfig, host: string, port: Port): ConnIO =
  let 
    peer = getAddrInfo(host, port, Domain.AF_UNSPEC, SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP)
    sock = newAsyncSocket(Domain.AF_INET, SockType.SOCK_DGRAM, Protocol.IPPROTO_UDP)
    scid = genConnectionId()
  
  var
    localSockAddr: SockAddr
    localSockLen: SockLen

    peerSockAddr: SockAddr
    peerSockLen: SockLen

  if getsockname(sock.getFd(), localSockAddr.addr, localSockLen.addr) != cint(0):
    raise newException(Exception, "unable to get local socket address")

  echo "peer addr family: " & $peer.ai_family
  echo "got local socket addr: " &  $localSockAddr
  let conn = connection.connect(host, scid, localSockAddr.addr, localSockLen, peer.ai_addr, SockLen(peer.ai_addrlen), cfg)

  ConnIO(peerAddr: peer, conn: conn)

when isMainModule:
  echo "quiche version: ", version()
  discard quiche_enable_debug_logging(debugLog, nil)
  let cfg = makeConfig()

  let conn = connectPeer(cfg, "localhost", Port(4321))
  echo "conn: " & $conn



