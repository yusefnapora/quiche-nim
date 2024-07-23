import ffi
import errors

type
  PacketType* = enum
    Initial = 1,
    Retry = 2,
    Handshake = 3,
    ZeroRTT = 4,
    Short = 5,
    VersionNegotiation = 6

  PacketHeader* = object
    ## The type of the packet.
    packetType: PacketType
    ## The version of the packet.
    version: uint32
    ## The source connection ID of the packet.
    scid: seq[byte]
    ## The destination connection ID of the packet.
    dcid: seq[byte]
    ## The address verification token of the packet. Only present in `Initial` and `Retry` packets.
    token: seq[byte]

const SIZEOF_SOCKADDR_STORAGE = 128 # sizeof() complains that sys/posix/Sockaddr_storage doesn't have a known size
const MAX_TOKEN_LEN = 6 + SIZEOF_SOCKADDR_STORAGE + QUICHE_MAX_CONN_ID_LEN

## Extracts version, type, source / destination connection ID and address
## verification token from the given packet buffer.
proc get_header_info*(packet: openArray[byte], localConnIdLen: csize_t): Result[PacketHeader, QuicheError] =
  var scidBuf: array[0..QUICHE_MAX_CONN_ID_LEN, uint8]
  var scidLen: csize_t
  var dcidBuf: array[0..QUICHE_MAX_CONN_ID_LEN, uint8]
  var dcidLen: csize_t
  var tokenBuf: array[0..MAX_TOKEN_LEN, uint8]
  var tokenLen: csize_t
  var version: uint32
  var typeCode: uint8
  ?quiche_header_info(
    cast[ptr uint8](packet.addr),
    csize_t(packet.len),
    localConnIdLen,
    version.addr,
    typeCode.addr,
    scidBuf[0].addr,
    scidLen.addr,
    dcidBuf[0].addr,
    dcidLen.addr,
    tokenBuf[0].addr,
    tokenLen.addr,
  ).toQuicheResult()
  
  ok(PacketHeader(
    packetType: PacketType(typeCode),
    version: version,
    scid: scidBuf[0..scidLen],
    dcid: dcidBuf[0..dcidLen],
    token: tokenBuf[0..tokenLen]
  ))
