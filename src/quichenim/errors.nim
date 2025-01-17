import ffi
import results
export results

type
  QuicheError* = enum
    ## The peer sent more data in CRYPTO frames than we can buffer.
    CryptoBufferExceeded = enum_quiche_error.QUICHE_ERR_CRYPTO_BUFFER_EXCEEDED,

    ## Error in key update.
    KeyUpdate = enum_quiche_error.QUICHE_ERR_KEY_UPDATE,

    ## Not enough available identifiers.
    OutOfIdentifiers = enum_quiche_error.QUICHE_ERR_OUT_OF_IDENTIFIERS,
    
    ## Too many identifiers were provided.
    IdLimit = enum_quiche_error.QUICHE_ERR_ID_LIMIT,

    ## The specified stream was reset by the peer.
    StreamReset = enum_quiche_error.QUICHE_ERR_STREAM_RESET,

    ## The specified stream was stopped by the peer.
    StreamStopped = enum_quiche_error.QUICHE_ERR_STREAM_STOPPED,

    ## Error in congestion control.
    CongestionControl = enum_quiche_error.QUICHE_ERR_CONGESTION_CONTROL,

    ## The received data exceeds the stream's final size.
    FinalSize = enum_quiche_error.QUICHE_ERR_FINAL_SIZE,

    ## The peer violated the local stream limits.
    StreamLimit = enum_quiche_error.QUICHE_ERR_STREAM_LIMIT,

    ## The peer violated the local flow control limits.
    FlowControl = enum_quiche_error.QUICHE_ERR_FLOW_CONTROL,

    ## The TLS handshake failed.
    TLSFail = enum_quiche_error.QUICHE_ERR_TLS_FAIL,

    ## A cryptographic operation failed.
    CryptoFail = enum_quiche_error.QUICHE_ERR_CRYPTO_FAIL,

    ## The peer's transport params cannot be parsed.
    InvalidTransportParam = enum_quiche_error.QUICHE_ERR_INVALID_TRANSPORT_PARAM,

    ## The operation cannot be completed because the stream is in an invalid state.
    InvalidStreamState = enum_quiche_error.QUICHE_ERR_INVALID_STREAM_STATE,

    ## The operation cannot be completed because the connection is in an invalid state.
    InvalidState = enum_quiche_error.QUICHE_ERR_INVALID_STATE,

    ## The provided packet cannot be parsed.
    InvalidPacket = enum_quiche_error.QUICHE_ERR_INVALID_PACKET,

    ## The provided packet cannot be parsed because it contains an invalid frame. 
    InvalidFrame = enum_quiche_error.QUICHE_ERR_INVALID_FRAME,

    ## The provided packet cannot be parsed because it contains an invalid frame.
    UnknownVersion = enum_quiche_error.QUICHE_ERR_UNKNOWN_VERSION,

    ## The provided buffer is too short.
    BufferTooShort = enum_quiche_error.QUICHE_ERR_BUFFER_TOO_SHORT,

    ## There is no more work to do.
    Done = enum_quiche_error.QUICHE_ERR_DONE,


  QuicheResult* = Result[void, QuicheError]

  SignedSizeT* {.importc: "ssize_t", nodecl.} = int
  SizeResult* = Result[csize_t, QuicheError]

  BoolResult* = Result[bool, QuicheError]


proc toQuicheError*(code: int): QuicheError =
  case code:
    of ord(low(QuicheError))..ord(high(QuicheError)):
      QuicheError(code)
    else:
      raise newException(KeyError, "Unexpected error code: " & $code)

## Converts an integer return value from a quiche FFI call into
## a `Result[void, QuicheError]` (aka `QuicheResult`)
proc toQuicheResult*(code: int): QuicheResult =
  case code:
    of 0: ok()
    else: err(code.toQuicheError())

## Converts an integer return value which can either be true (1), false (0), or an error (< 0)
## into a `Result[bool, QuicheError]` (aka `BoolResult`)
proc toBoolResult*(code: int): BoolResult =
  case code:
    of 1: ok(true)
    of 0: ok(false)
    else: err(code.toQuicheError())

## Converts an `ssize_t` from a quiche FFI call into either a `csize_t` success value 
## or a `QuicheError` if the `size` value is negative.
proc toSizeResult*(size: SignedSizeT): SizeResult =
  case size:
    of 0..high(SignedSizeT):
      ok(csize_t(size))
    else:
      err(size.toQuicheError())
