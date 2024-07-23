
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}
from macros import hint

from os import parentDir

when not declared(enum_quiche_error):
  type
    enum_quiche_error* {.size: sizeof(cint).} = enum
      QUICHE_ERR_CRYPTO_BUFFER_EXCEEDED = -20, QUICHE_ERR_KEY_UPDATE = -19,
      QUICHE_ERR_OUT_OF_IDENTIFIERS = -18, QUICHE_ERR_ID_LIMIT = -17,
      QUICHE_ERR_STREAM_RESET = -16, QUICHE_ERR_STREAM_STOPPED = -15,
      QUICHE_ERR_CONGESTION_CONTROL = -14, QUICHE_ERR_FINAL_SIZE = -13,
      QUICHE_ERR_STREAM_LIMIT = -12, QUICHE_ERR_FLOW_CONTROL = -11,
      QUICHE_ERR_TLS_FAIL = -10, QUICHE_ERR_CRYPTO_FAIL = -9,
      QUICHE_ERR_INVALID_TRANSPORT_PARAM = -8,
      QUICHE_ERR_INVALID_STREAM_STATE = -7, QUICHE_ERR_INVALID_STATE = -6,
      QUICHE_ERR_INVALID_PACKET = -5, QUICHE_ERR_INVALID_FRAME = -4,
      QUICHE_ERR_UNKNOWN_VERSION = -3, QUICHE_ERR_BUFFER_TOO_SHORT = -2,
      QUICHE_ERR_DONE = -1
else:
  static :
    hint("Declaration of " & "enum_quiche_error" &
        " already exists, not redeclaring")
when not declared(enum_quiche_cc_algorithm):
  type
    enum_quiche_cc_algorithm* {.size: sizeof(cuint).} = enum
      QUICHE_CC_RENO = 0, QUICHE_CC_CUBIC = 1, QUICHE_CC_BBR = 2,
      QUICHE_CC_BBR2 = 3
else:
  static :
    hint("Declaration of " & "enum_quiche_cc_algorithm" &
        " already exists, not redeclaring")
when not declared(enum_quiche_shutdown):
  type
    enum_quiche_shutdown* {.size: sizeof(cuint).} = enum
      QUICHE_SHUTDOWN_READ = 0, QUICHE_SHUTDOWN_WRITE = 1
else:
  static :
    hint("Declaration of " & "enum_quiche_shutdown" &
        " already exists, not redeclaring")
when not declared(enum_quiche_path_event_type):
  type
    enum_quiche_path_event_type* {.size: sizeof(cuint).} = enum
      QUICHE_PATH_EVENT_NEW = 0, QUICHE_PATH_EVENT_VALIDATED = 1,
      QUICHE_PATH_EVENT_FAILED_VALIDATION = 2, QUICHE_PATH_EVENT_CLOSED = 3,
      QUICHE_PATH_EVENT_REUSED_SOURCE_CONNECTION_ID = 4,
      QUICHE_PATH_EVENT_PEER_MIGRATED = 5
else:
  static :
    hint("Declaration of " & "enum_quiche_path_event_type" &
        " already exists, not redeclaring")
when not declared(enum_quiche_h3_error):
  type
    enum_quiche_h3_error* {.size: sizeof(cint).} = enum
      QUICHE_H3_TRANSPORT_ERR_KEY_UPDATE = -1019,
      QUICHE_H3_TRANSPORT_ERR_OUT_OF_IDENTIFIERS = -1018,
      QUICHE_H3_TRANSPORT_ERR_ID_LIMIT = -1017,
      QUICHE_H3_TRANSPORT_ERR_STREAM_RESET = -1016,
      QUICHE_H3_TRANSPORT_ERR_STREAM_STOPPED = -1015,
      QUICHE_H3_TRANSPORT_ERR_CONGESTION_CONTROL = -1014,
      QUICHE_H3_TRANSPORT_ERR_FINAL_SIZE = -1013,
      QUICHE_H3_TRANSPORT_ERR_STREAM_LIMIT = -1012,
      QUICHE_H3_TRANSPORT_ERR_FLOW_CONTROL = -1011,
      QUICHE_H3_TRANSPORT_ERR_TLS_FAIL = -1010,
      QUICHE_H3_TRANSPORT_ERR_CRYPTO_FAIL = -1009,
      QUICHE_H3_TRANSPORT_ERR_INVALID_TRANSPORT_PARAM = -1008,
      QUICHE_H3_TRANSPORT_ERR_INVALID_STREAM_STATE = -1007,
      QUICHE_H3_TRANSPORT_ERR_INVALID_STATE = -1006,
      QUICHE_H3_TRANSPORT_ERR_INVALID_PACKET = -1005,
      QUICHE_H3_TRANSPORT_ERR_INVALID_FRAME = -1004,
      QUICHE_H3_TRANSPORT_ERR_UNKNOWN_VERSION = -1003,
      QUICHE_H3_TRANSPORT_ERR_BUFFER_TOO_SHORT = -1002,
      QUICHE_H3_TRANSPORT_ERR_DONE = -1001,
      QUICHE_H3_ERR_VERSION_FALLBACK = -20, QUICHE_H3_ERR_CONNECT_ERROR = -19,
      QUICHE_H3_ERR_MESSAGE_ERROR = -18, QUICHE_H3_ERR_REQUEST_INCOMPLETE = -17,
      QUICHE_H3_ERR_REQUEST_CANCELLED = -16,
      QUICHE_H3_ERR_REQUEST_REJECTED = -15, QUICHE_H3_ERR_SETTINGS_ERROR = -14,
      QUICHE_H3_ERR_STREAM_BLOCKED = -13,
      QUICHE_H3_ERR_QPACK_DECOMPRESSION_FAILED = -11,
      QUICHE_H3_ERR_FRAME_ERROR = -10, QUICHE_H3_ERR_FRAME_UNEXPECTED = -9,
      QUICHE_H3_ERR_MISSING_SETTINGS = -8,
      QUICHE_H3_ERR_CLOSED_CRITICAL_STREAM = -7,
      QUICHE_H3_ERR_STREAM_CREATION_ERROR = -6, QUICHE_H3_ERR_ID_ERROR = -5,
      QUICHE_H3_ERR_EXCESSIVE_LOAD = -4, QUICHE_H3_ERR_INTERNAL_ERROR = -3,
      QUICHE_H3_ERR_BUFFER_TOO_SHORT = -2, QUICHE_H3_ERR_DONE = -1
else:
  static :
    hint("Declaration of " & "enum_quiche_h3_error" &
        " already exists, not redeclaring")
when not declared(enum_quiche_h3_event_type):
  type
    enum_quiche_h3_event_type* {.size: sizeof(cuint).} = enum
      QUICHE_H3_EVENT_HEADERS = 0, QUICHE_H3_EVENT_DATA = 1,
      QUICHE_H3_EVENT_FINISHED = 2, QUICHE_H3_EVENT_GOAWAY = 3,
      QUICHE_H3_EVENT_RESET = 4, QUICHE_H3_EVENT_PRIORITY_UPDATE = 5
else:
  static :
    hint("Declaration of " & "enum_quiche_h3_event_type" &
        " already exists, not redeclaring")
when not declared(struct_quiche_h3_event):
  type
    struct_quiche_h3_event* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_h3_event" &
        " already exists, not redeclaring")
when not declared(struct_quiche_socket_addr_iter):
  type
    struct_quiche_socket_addr_iter* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_socket_addr_iter" &
        " already exists, not redeclaring")
when not declared(struct_quiche_stream_iter):
  type
    struct_quiche_stream_iter* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_stream_iter" &
        " already exists, not redeclaring")
when not declared(struct_quiche_path_event):
  type
    struct_quiche_path_event* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_path_event" &
        " already exists, not redeclaring")
when not declared(struct_quiche_connection_id_iter):
  type
    struct_quiche_connection_id_iter* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_connection_id_iter" &
        " already exists, not redeclaring")
when not declared(struct_quiche_conn):
  type
    struct_quiche_conn* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_conn" &
        " already exists, not redeclaring")
when not declared(struct_quiche_config):
  type
    struct_quiche_config* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_config" &
        " already exists, not redeclaring")
when not declared(struct_quiche_h3_config):
  type
    struct_quiche_h3_config* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_h3_config" &
        " already exists, not redeclaring")
when not declared(struct_quiche_h3_conn):
  type
    struct_quiche_h3_conn* = object
else:
  static :
    hint("Declaration of " & "struct_quiche_h3_conn" &
        " already exists, not redeclaring")
type
  quiche_config_1392509372 = struct_quiche_config ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:140:30
  quiche_conn_1392509376 = struct_quiche_conn ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:281:28
  struct_sockaddr_1392509378 {.pure, inheritable, bycopy.} = object
    sa_len*: compiler_uint8_t_1392509442 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/socket.h:404:8
    sa_family*: sa_family_t_1392509451
    sa_data*: array[14'i64, cschar]
  socklen_t_1392509380 = compiler_darwin_socklen_t_1392509453 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/_types/_socklen_t.h:30:28
  ssize_t_1392509382 = compiler_darwin_ssize_t_1392509455 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/_types/_ssize_t.h:30:33
  struct_quiche_recv_info_1392509384 {.pure, inheritable, bycopy.} = object
    from_field*: ptr struct_sockaddr_1392509379 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:336:9
    from_len*: socklen_t_1392509381
    to*: ptr struct_sockaddr_1392509379
    to_len*: socklen_t_1392509381
  quiche_recv_info_1392509386 = struct_quiche_recv_info_1392509385 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:344:3
  struct_quiche_send_info_1392509388 {.pure, inheritable, bycopy.} = object
    from_field*: struct_sockaddr_storage_1392509391 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:350:9
    from_len*: socklen_t_1392509381
    to*: struct_sockaddr_storage_1392509391
    to_len*: socklen_t_1392509381
    at*: struct_timespec_1392509393
  struct_sockaddr_storage_1392509390 {.pure, inheritable, bycopy.} = object
    ss_len*: compiler_uint8_t_1392509442 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/socket.h:437:8
    ss_family*: sa_family_t_1392509451
    compiler_ss_pad1*: array[6'i64, cschar]
    compiler_ss_align*: compiler_int64_t_1392509457
    compiler_ss_pad2*: array[112'i64, cschar]
  struct_timespec_1392509392 {.pure, inheritable, bycopy.} = object
    tv_sec*: compiler_darwin_time_t_1392509459 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/_types/_timespec.h:30:1
    tv_nsec*: clong
  quiche_send_info_1392509394 = struct_quiche_send_info_1392509389 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:361:3
  quiche_stream_iter_1392509398 = struct_quiche_stream_iter ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:433:35
  quiche_connection_id_iter_1392509400 = struct_quiche_connection_id_iter ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:463:42
  struct_quiche_stats_1392509402 {.pure, inheritable, bycopy.} = object
    recv*: csize_t           ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:541:9
    sent*: csize_t
    lost*: csize_t
    retrans*: csize_t
    sent_bytes*: uint64
    recv_bytes*: uint64
    acked_bytes*: uint64
    lost_bytes*: uint64
    stream_retrans_bytes*: uint64
    paths_count*: csize_t
    reset_stream_count_local*: uint64
    stopped_stream_count_local*: uint64
    reset_stream_count_remote*: uint64
    stopped_stream_count_remote*: uint64
  quiche_stats_1392509404 = struct_quiche_stats_1392509403 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:583:3
  struct_quiche_transport_params_1392509406 {.pure, inheritable, bycopy.} = object
    peer_max_idle_timeout*: uint64 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:588:9
    peer_max_udp_payload_size*: uint64
    peer_initial_max_data*: uint64
    peer_initial_max_stream_data_bidi_local*: uint64
    peer_initial_max_stream_data_bidi_remote*: uint64
    peer_initial_max_stream_data_uni*: uint64
    peer_initial_max_streams_bidi*: uint64
    peer_initial_max_streams_uni*: uint64
    peer_ack_delay_exponent*: uint64
    peer_max_ack_delay*: uint64
    peer_disable_active_migration*: bool
    peer_active_conn_id_limit*: uint64
    peer_max_datagram_frame_size*: ssize_t_1392509383
  quiche_transport_params_1392509408 = struct_quiche_transport_params_1392509407 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:627:3
  struct_quiche_path_stats_1392509410 {.pure, inheritable, bycopy.} = object
    local_addr*: struct_sockaddr_storage_1392509391 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:633:9
    local_addr_len*: socklen_t_1392509381
    peer_addr*: struct_sockaddr_storage_1392509391
    peer_addr_len*: socklen_t_1392509381
    validation_state*: ssize_t_1392509383
    active*: bool
    recv*: csize_t
    sent*: csize_t
    lost*: csize_t
    retrans*: csize_t
    rtt*: uint64
    cwnd*: csize_t
    sent_bytes*: uint64
    recv_bytes*: uint64
    lost_bytes*: uint64
    stream_retrans_bytes*: uint64
    pmtu*: csize_t
    delivery_rate*: uint64
  quiche_path_stats_1392509412 = struct_quiche_path_stats_1392509411 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:683:3
  quiche_path_event_1392509416 = struct_quiche_path_event ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:787:34
  quiche_socket_addr_iter_1392509418 = struct_quiche_socket_addr_iter ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:830:40
  quiche_h3_config_1392509422 = struct_quiche_h3_config ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:996:33
  quiche_h3_conn_1392509424 = struct_quiche_h3_conn ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1017:31
  quiche_h3_event_1392509428 = struct_quiche_h3_event ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1032:32
  struct_quiche_h3_header_1392509430 {.pure, inheritable, bycopy.} = object
    name*: ptr uint8         ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1072:9
    name_len*: csize_t
    value*: ptr uint8
    value_len*: csize_t
  quiche_h3_header_1392509432 = struct_quiche_h3_header_1392509431 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1078:3
  struct_quiche_h3_priority_1392509434 {.pure, inheritable, bycopy.} = object
    urgency*: uint8          ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1081:9
    incremental*: bool
  quiche_h3_priority_1392509436 = struct_quiche_h3_priority_1392509435 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:1084:3
  compiler_uint8_t_1392509441 = uint8 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:41:24
  sa_family_t_1392509450 = compiler_uint8_t_1392509442 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/sys/_types/_sa_family_t.h:30:20
  compiler_darwin_socklen_t_1392509452 = compiler_uint32_t_1392509461 ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:118:21
  compiler_darwin_ssize_t_1392509454 = clong ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:119:16
  compiler_int64_t_1392509456 = clonglong ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:46:20
  compiler_darwin_time_t_1392509458 = clong ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:120:16
  compiler_uint32_t_1392509460 = cuint ## Generated based on /nix/store/7z4q9n16isx35j32cc9vp1nz0v8nicwf-Libsystem-1238.60.2/include/i386/_types.h:45:23
  struct_quiche_transport_params_1392509407 = (when declared(
      struct_quiche_transport_params):
    struct_quiche_transport_params
   else:
    struct_quiche_transport_params_1392509406)
  quiche_stream_iter_1392509399 = (when declared(quiche_stream_iter):
    quiche_stream_iter
   else:
    quiche_stream_iter_1392509398)
  compiler_int64_t_1392509457 = (when declared(compiler_int64_t):
    compiler_int64_t
   else:
    compiler_int64_t_1392509456)
  quiche_h3_event_1392509429 = (when declared(quiche_h3_event):
    quiche_h3_event
   else:
    quiche_h3_event_1392509428)
  quiche_transport_params_1392509409 = (when declared(quiche_transport_params):
    quiche_transport_params
   else:
    quiche_transport_params_1392509408)
  enum_quiche_path_event_type_1392509415 = (when declared(
      enum_quiche_path_event_type):
    enum_quiche_path_event_type
   else:
    enum_quiche_path_event_type_1392509414)
  quiche_config_1392509373 = (when declared(quiche_config):
    quiche_config
   else:
    quiche_config_1392509372)
  quiche_path_event_1392509417 = (when declared(quiche_path_event):
    quiche_path_event
   else:
    quiche_path_event_1392509416)
  quiche_h3_header_1392509433 = (when declared(quiche_h3_header):
    quiche_h3_header
   else:
    quiche_h3_header_1392509432)
  compiler_uint8_t_1392509442 = (when declared(compiler_uint8_t):
    compiler_uint8_t
   else:
    compiler_uint8_t_1392509441)
  quiche_socket_addr_iter_1392509419 = (when declared(quiche_socket_addr_iter):
    quiche_socket_addr_iter
   else:
    quiche_socket_addr_iter_1392509418)
  struct_quiche_recv_info_1392509385 = (when declared(struct_quiche_recv_info):
    struct_quiche_recv_info
   else:
    struct_quiche_recv_info_1392509384)
  struct_sockaddr_1392509379 = (when declared(struct_sockaddr):
    struct_sockaddr
   else:
    struct_sockaddr_1392509378)
  quiche_connection_id_iter_1392509401 = (when declared(
      quiche_connection_id_iter):
    quiche_connection_id_iter
   else:
    quiche_connection_id_iter_1392509400)
  struct_quiche_h3_priority_1392509435 = (when declared(
      struct_quiche_h3_priority):
    struct_quiche_h3_priority
   else:
    struct_quiche_h3_priority_1392509434)
  enum_quiche_cc_algorithm_1392509375 = (when declared(enum_quiche_cc_algorithm):
    enum_quiche_cc_algorithm
   else:
    enum_quiche_cc_algorithm_1392509374)
  quiche_h3_conn_1392509425 = (when declared(quiche_h3_conn):
    quiche_h3_conn
   else:
    quiche_h3_conn_1392509424)
  compiler_uint32_t_1392509461 = (when declared(compiler_uint32_t):
    compiler_uint32_t
   else:
    compiler_uint32_t_1392509460)
  quiche_h3_config_1392509423 = (when declared(quiche_h3_config):
    quiche_h3_config
   else:
    quiche_h3_config_1392509422)
  quiche_recv_info_1392509387 = (when declared(quiche_recv_info):
    quiche_recv_info
   else:
    quiche_recv_info_1392509386)
  struct_quiche_path_stats_1392509411 = (when declared(struct_quiche_path_stats):
    struct_quiche_path_stats
   else:
    struct_quiche_path_stats_1392509410)
  struct_quiche_send_info_1392509389 = (when declared(struct_quiche_send_info):
    struct_quiche_send_info
   else:
    struct_quiche_send_info_1392509388)
  socklen_t_1392509381 = (when declared(socklen_t):
    socklen_t
   else:
    socklen_t_1392509380)
  enum_quiche_h3_event_type_1392509427 = (when declared(
      enum_quiche_h3_event_type):
    enum_quiche_h3_event_type
   else:
    enum_quiche_h3_event_type_1392509426)
  quiche_path_stats_1392509413 = (when declared(quiche_path_stats):
    quiche_path_stats
   else:
    quiche_path_stats_1392509412)
  enum_quiche_error_1392509371 = (when declared(enum_quiche_error):
    enum_quiche_error
   else:
    enum_quiche_error_1392509369)
  compiler_darwin_time_t_1392509459 = (when declared(compiler_darwin_time_t):
    compiler_darwin_time_t
   else:
    compiler_darwin_time_t_1392509458)
  sa_family_t_1392509451 = (when declared(sa_family_t):
    sa_family_t
   else:
    sa_family_t_1392509450)
  quiche_h3_priority_1392509437 = (when declared(quiche_h3_priority):
    quiche_h3_priority
   else:
    quiche_h3_priority_1392509436)
  compiler_darwin_ssize_t_1392509455 = (when declared(compiler_darwin_ssize_t):
    compiler_darwin_ssize_t
   else:
    compiler_darwin_ssize_t_1392509454)
  quiche_send_info_1392509395 = (when declared(quiche_send_info):
    quiche_send_info
   else:
    quiche_send_info_1392509394)
  struct_timespec_1392509393 = (when declared(struct_timespec):
    struct_timespec
   else:
    struct_timespec_1392509392)
  struct_quiche_stats_1392509403 = (when declared(struct_quiche_stats):
    struct_quiche_stats
   else:
    struct_quiche_stats_1392509402)
  struct_quiche_h3_header_1392509431 = (when declared(struct_quiche_h3_header):
    struct_quiche_h3_header
   else:
    struct_quiche_h3_header_1392509430)
  struct_sockaddr_storage_1392509391 = (when declared(struct_sockaddr_storage):
    struct_sockaddr_storage
   else:
    struct_sockaddr_storage_1392509390)
  quiche_conn_1392509377 = (when declared(quiche_conn):
    quiche_conn
   else:
    quiche_conn_1392509376)
  ssize_t_1392509383 = (when declared(ssize_t):
    ssize_t
   else:
    ssize_t_1392509382)
  quiche_stats_1392509405 = (when declared(quiche_stats):
    quiche_stats
   else:
    quiche_stats_1392509404)
  enum_quiche_h3_error_1392509421 = (when declared(enum_quiche_h3_error):
    enum_quiche_h3_error
   else:
    enum_quiche_h3_error_1392509420)
  compiler_darwin_socklen_t_1392509453 = (when declared(
      compiler_darwin_socklen_t):
    compiler_darwin_socklen_t
   else:
    compiler_darwin_socklen_t_1392509452)
  enum_quiche_shutdown_1392509397 = (when declared(enum_quiche_shutdown):
    enum_quiche_shutdown
   else:
    enum_quiche_shutdown_1392509396)
when not declared(struct_quiche_transport_params):
  type
    struct_quiche_transport_params* = struct_quiche_transport_params_1392509406
else:
  static :
    hint("Declaration of " & "struct_quiche_transport_params" &
        " already exists, not redeclaring")
when not declared(quiche_stream_iter):
  type
    quiche_stream_iter* = quiche_stream_iter_1392509398
else:
  static :
    hint("Declaration of " & "quiche_stream_iter" &
        " already exists, not redeclaring")
when not declared(compiler_int64_t):
  type
    compiler_int64_t* = compiler_int64_t_1392509456
else:
  static :
    hint("Declaration of " & "compiler_int64_t" &
        " already exists, not redeclaring")
when not declared(quiche_h3_event):
  type
    quiche_h3_event* = quiche_h3_event_1392509428
else:
  static :
    hint("Declaration of " & "quiche_h3_event" &
        " already exists, not redeclaring")
when not declared(quiche_transport_params):
  type
    quiche_transport_params* = quiche_transport_params_1392509408
else:
  static :
    hint("Declaration of " & "quiche_transport_params" &
        " already exists, not redeclaring")
when not declared(quiche_config):
  type
    quiche_config* = quiche_config_1392509372
else:
  static :
    hint("Declaration of " & "quiche_config" &
        " already exists, not redeclaring")
when not declared(quiche_path_event):
  type
    quiche_path_event* = quiche_path_event_1392509416
else:
  static :
    hint("Declaration of " & "quiche_path_event" &
        " already exists, not redeclaring")
when not declared(quiche_h3_header):
  type
    quiche_h3_header* = quiche_h3_header_1392509432
else:
  static :
    hint("Declaration of " & "quiche_h3_header" &
        " already exists, not redeclaring")
when not declared(compiler_uint8_t):
  type
    compiler_uint8_t* = compiler_uint8_t_1392509441
else:
  static :
    hint("Declaration of " & "compiler_uint8_t" &
        " already exists, not redeclaring")
when not declared(quiche_socket_addr_iter):
  type
    quiche_socket_addr_iter* = quiche_socket_addr_iter_1392509418
else:
  static :
    hint("Declaration of " & "quiche_socket_addr_iter" &
        " already exists, not redeclaring")
when not declared(struct_quiche_recv_info):
  type
    struct_quiche_recv_info* = struct_quiche_recv_info_1392509384
else:
  static :
    hint("Declaration of " & "struct_quiche_recv_info" &
        " already exists, not redeclaring")
when not declared(struct_sockaddr):
  type
    struct_sockaddr* = struct_sockaddr_1392509378
else:
  static :
    hint("Declaration of " & "struct_sockaddr" &
        " already exists, not redeclaring")
when not declared(quiche_connection_id_iter):
  type
    quiche_connection_id_iter* = quiche_connection_id_iter_1392509400
else:
  static :
    hint("Declaration of " & "quiche_connection_id_iter" &
        " already exists, not redeclaring")
when not declared(struct_quiche_h3_priority):
  type
    struct_quiche_h3_priority* = struct_quiche_h3_priority_1392509434
else:
  static :
    hint("Declaration of " & "struct_quiche_h3_priority" &
        " already exists, not redeclaring")
when not declared(quiche_h3_conn):
  type
    quiche_h3_conn* = quiche_h3_conn_1392509424
else:
  static :
    hint("Declaration of " & "quiche_h3_conn" &
        " already exists, not redeclaring")
when not declared(compiler_uint32_t):
  type
    compiler_uint32_t* = compiler_uint32_t_1392509460
else:
  static :
    hint("Declaration of " & "compiler_uint32_t" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config):
  type
    quiche_h3_config* = quiche_h3_config_1392509422
else:
  static :
    hint("Declaration of " & "quiche_h3_config" &
        " already exists, not redeclaring")
when not declared(quiche_recv_info):
  type
    quiche_recv_info* = quiche_recv_info_1392509386
else:
  static :
    hint("Declaration of " & "quiche_recv_info" &
        " already exists, not redeclaring")
when not declared(struct_quiche_path_stats):
  type
    struct_quiche_path_stats* = struct_quiche_path_stats_1392509410
else:
  static :
    hint("Declaration of " & "struct_quiche_path_stats" &
        " already exists, not redeclaring")
when not declared(struct_quiche_send_info):
  type
    struct_quiche_send_info* = struct_quiche_send_info_1392509388
else:
  static :
    hint("Declaration of " & "struct_quiche_send_info" &
        " already exists, not redeclaring")
when not declared(socklen_t):
  type
    socklen_t* = socklen_t_1392509380
else:
  static :
    hint("Declaration of " & "socklen_t" & " already exists, not redeclaring")
when not declared(quiche_path_stats):
  type
    quiche_path_stats* = quiche_path_stats_1392509412
else:
  static :
    hint("Declaration of " & "quiche_path_stats" &
        " already exists, not redeclaring")
when not declared(compiler_darwin_time_t):
  type
    compiler_darwin_time_t* = compiler_darwin_time_t_1392509458
else:
  static :
    hint("Declaration of " & "compiler_darwin_time_t" &
        " already exists, not redeclaring")
when not declared(sa_family_t):
  type
    sa_family_t* = sa_family_t_1392509450
else:
  static :
    hint("Declaration of " & "sa_family_t" & " already exists, not redeclaring")
when not declared(quiche_h3_priority):
  type
    quiche_h3_priority* = quiche_h3_priority_1392509436
else:
  static :
    hint("Declaration of " & "quiche_h3_priority" &
        " already exists, not redeclaring")
when not declared(compiler_darwin_ssize_t):
  type
    compiler_darwin_ssize_t* = compiler_darwin_ssize_t_1392509454
else:
  static :
    hint("Declaration of " & "compiler_darwin_ssize_t" &
        " already exists, not redeclaring")
when not declared(quiche_send_info):
  type
    quiche_send_info* = quiche_send_info_1392509394
else:
  static :
    hint("Declaration of " & "quiche_send_info" &
        " already exists, not redeclaring")
when not declared(struct_timespec):
  type
    struct_timespec* = struct_timespec_1392509392
else:
  static :
    hint("Declaration of " & "struct_timespec" &
        " already exists, not redeclaring")
when not declared(struct_quiche_stats):
  type
    struct_quiche_stats* = struct_quiche_stats_1392509402
else:
  static :
    hint("Declaration of " & "struct_quiche_stats" &
        " already exists, not redeclaring")
when not declared(struct_quiche_h3_header):
  type
    struct_quiche_h3_header* = struct_quiche_h3_header_1392509430
else:
  static :
    hint("Declaration of " & "struct_quiche_h3_header" &
        " already exists, not redeclaring")
when not declared(struct_sockaddr_storage):
  type
    struct_sockaddr_storage* = struct_sockaddr_storage_1392509390
else:
  static :
    hint("Declaration of " & "struct_sockaddr_storage" &
        " already exists, not redeclaring")
when not declared(quiche_conn):
  type
    quiche_conn* = quiche_conn_1392509376
else:
  static :
    hint("Declaration of " & "quiche_conn" & " already exists, not redeclaring")
when not declared(ssize_t):
  type
    ssize_t* = ssize_t_1392509382
else:
  static :
    hint("Declaration of " & "ssize_t" & " already exists, not redeclaring")
when not declared(quiche_stats):
  type
    quiche_stats* = quiche_stats_1392509404
else:
  static :
    hint("Declaration of " & "quiche_stats" & " already exists, not redeclaring")
when not declared(compiler_darwin_socklen_t):
  type
    compiler_darwin_socklen_t* = compiler_darwin_socklen_t_1392509452
else:
  static :
    hint("Declaration of " & "compiler_darwin_socklen_t" &
        " already exists, not redeclaring")
when not declared(QUICHE_PROTOCOL_VERSION):
  when 1 is static:
    const
      QUICHE_PROTOCOL_VERSION* = 1 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:59:9
  else:
    let QUICHE_PROTOCOL_VERSION* = 1 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:59:9
else:
  static :
    hint("Declaration of " & "QUICHE_PROTOCOL_VERSION" &
        " already exists, not redeclaring")
when not declared(QUICHE_MAX_CONN_ID_LEN):
  when 20 is static:
    const
      QUICHE_MAX_CONN_ID_LEN* = 20 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:62:9
  else:
    let QUICHE_MAX_CONN_ID_LEN* = 20 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:62:9
else:
  static :
    hint("Declaration of " & "QUICHE_MAX_CONN_ID_LEN" &
        " already exists, not redeclaring")
when not declared(QUICHE_MIN_CLIENT_INITIAL_LEN):
  when 1200 is static:
    const
      QUICHE_MIN_CLIENT_INITIAL_LEN* = 1200 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:65:9
  else:
    let QUICHE_MIN_CLIENT_INITIAL_LEN* = 1200 ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:65:9
else:
  static :
    hint("Declaration of " & "QUICHE_MIN_CLIENT_INITIAL_LEN" &
        " already exists, not redeclaring")
when not declared(QUICHE_H3_APPLICATION_PROTOCOL):
  when "\\x02h3" is static:
    const
      QUICHE_H3_APPLICATION_PROTOCOL* = "\\x02h3" ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:864:9
  else:
    let QUICHE_H3_APPLICATION_PROTOCOL* = "\\x02h3" ## Generated based on /Users/yusef/personal/nim/quiche-nim/src/quichenim/artifacts/quiche.h:864:9
else:
  static :
    hint("Declaration of " & "QUICHE_H3_APPLICATION_PROTOCOL" &
        " already exists, not redeclaring")
when not declared(quiche_version):
  proc quiche_version*(): cstring {.cdecl, importc: "quiche_version".}
else:
  static :
    hint("Declaration of " & "quiche_version" &
        " already exists, not redeclaring")
when not declared(quiche_enable_debug_logging):
  proc quiche_enable_debug_logging*(cb: proc (a0: cstring; a1: pointer): void {.
      cdecl.}; argp: pointer): cint {.cdecl,
                                      importc: "quiche_enable_debug_logging".}
else:
  static :
    hint("Declaration of " & "quiche_enable_debug_logging" &
        " already exists, not redeclaring")
when not declared(quiche_config_new):
  proc quiche_config_new*(version: uint32): ptr quiche_config_1392509373 {.
      cdecl, importc: "quiche_config_new".}
else:
  static :
    hint("Declaration of " & "quiche_config_new" &
        " already exists, not redeclaring")
when not declared(quiche_config_load_cert_chain_from_pem_file):
  proc quiche_config_load_cert_chain_from_pem_file*(config: ptr quiche_config_1392509373;
      path: cstring): cint {.cdecl, importc: "quiche_config_load_cert_chain_from_pem_file".}
else:
  static :
    hint("Declaration of " & "quiche_config_load_cert_chain_from_pem_file" &
        " already exists, not redeclaring")
when not declared(quiche_config_load_priv_key_from_pem_file):
  proc quiche_config_load_priv_key_from_pem_file*(config: ptr quiche_config_1392509373;
      path: cstring): cint {.cdecl, importc: "quiche_config_load_priv_key_from_pem_file".}
else:
  static :
    hint("Declaration of " & "quiche_config_load_priv_key_from_pem_file" &
        " already exists, not redeclaring")
when not declared(quiche_config_load_verify_locations_from_file):
  proc quiche_config_load_verify_locations_from_file*(config: ptr quiche_config_1392509373;
      path: cstring): cint {.cdecl, importc: "quiche_config_load_verify_locations_from_file".}
else:
  static :
    hint("Declaration of " & "quiche_config_load_verify_locations_from_file" &
        " already exists, not redeclaring")
when not declared(quiche_config_load_verify_locations_from_directory):
  proc quiche_config_load_verify_locations_from_directory*(
      config: ptr quiche_config_1392509373; path: cstring): cint {.cdecl,
      importc: "quiche_config_load_verify_locations_from_directory".}
else:
  static :
    hint("Declaration of " &
        "quiche_config_load_verify_locations_from_directory" &
        " already exists, not redeclaring")
when not declared(quiche_config_verify_peer):
  proc quiche_config_verify_peer*(config: ptr quiche_config_1392509373; v: bool): void {.
      cdecl, importc: "quiche_config_verify_peer".}
else:
  static :
    hint("Declaration of " & "quiche_config_verify_peer" &
        " already exists, not redeclaring")
when not declared(quiche_config_grease):
  proc quiche_config_grease*(config: ptr quiche_config_1392509373; v: bool): void {.
      cdecl, importc: "quiche_config_grease".}
else:
  static :
    hint("Declaration of " & "quiche_config_grease" &
        " already exists, not redeclaring")
when not declared(quiche_config_discover_pmtu):
  proc quiche_config_discover_pmtu*(config: ptr quiche_config_1392509373;
                                    v: bool): void {.cdecl,
      importc: "quiche_config_discover_pmtu".}
else:
  static :
    hint("Declaration of " & "quiche_config_discover_pmtu" &
        " already exists, not redeclaring")
when not declared(quiche_config_log_keys):
  proc quiche_config_log_keys*(config: ptr quiche_config_1392509373): void {.
      cdecl, importc: "quiche_config_log_keys".}
else:
  static :
    hint("Declaration of " & "quiche_config_log_keys" &
        " already exists, not redeclaring")
when not declared(quiche_config_enable_early_data):
  proc quiche_config_enable_early_data*(config: ptr quiche_config_1392509373): void {.
      cdecl, importc: "quiche_config_enable_early_data".}
else:
  static :
    hint("Declaration of " & "quiche_config_enable_early_data" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_application_protos):
  proc quiche_config_set_application_protos*(config: ptr quiche_config_1392509373;
      protos: ptr uint8; protos_len: csize_t): cint {.cdecl,
      importc: "quiche_config_set_application_protos".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_application_protos" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_amplification_factor):
  proc quiche_config_set_max_amplification_factor*(config: ptr quiche_config_1392509373;
      v: csize_t): void {.cdecl,
                          importc: "quiche_config_set_max_amplification_factor".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_amplification_factor" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_idle_timeout):
  proc quiche_config_set_max_idle_timeout*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_max_idle_timeout".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_idle_timeout" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_recv_udp_payload_size):
  proc quiche_config_set_max_recv_udp_payload_size*(config: ptr quiche_config_1392509373;
      v: csize_t): void {.cdecl, importc: "quiche_config_set_max_recv_udp_payload_size".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_recv_udp_payload_size" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_send_udp_payload_size):
  proc quiche_config_set_max_send_udp_payload_size*(config: ptr quiche_config_1392509373;
      v: csize_t): void {.cdecl, importc: "quiche_config_set_max_send_udp_payload_size".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_send_udp_payload_size" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_data):
  proc quiche_config_set_initial_max_data*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_initial_max_data".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_initial_max_data" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_stream_data_bidi_local):
  proc quiche_config_set_initial_max_stream_data_bidi_local*(
      config: ptr quiche_config_1392509373; v: uint64): void {.cdecl,
      importc: "quiche_config_set_initial_max_stream_data_bidi_local".}
else:
  static :
    hint("Declaration of " &
        "quiche_config_set_initial_max_stream_data_bidi_local" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_stream_data_bidi_remote):
  proc quiche_config_set_initial_max_stream_data_bidi_remote*(
      config: ptr quiche_config_1392509373; v: uint64): void {.cdecl,
      importc: "quiche_config_set_initial_max_stream_data_bidi_remote".}
else:
  static :
    hint("Declaration of " &
        "quiche_config_set_initial_max_stream_data_bidi_remote" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_stream_data_uni):
  proc quiche_config_set_initial_max_stream_data_uni*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_initial_max_stream_data_uni".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_initial_max_stream_data_uni" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_streams_bidi):
  proc quiche_config_set_initial_max_streams_bidi*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl,
                         importc: "quiche_config_set_initial_max_streams_bidi".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_initial_max_streams_bidi" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_max_streams_uni):
  proc quiche_config_set_initial_max_streams_uni*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl,
                         importc: "quiche_config_set_initial_max_streams_uni".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_initial_max_streams_uni" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_ack_delay_exponent):
  proc quiche_config_set_ack_delay_exponent*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_ack_delay_exponent".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_ack_delay_exponent" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_ack_delay):
  proc quiche_config_set_max_ack_delay*(config: ptr quiche_config_1392509373;
                                        v: uint64): void {.cdecl,
      importc: "quiche_config_set_max_ack_delay".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_ack_delay" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_disable_active_migration):
  proc quiche_config_set_disable_active_migration*(config: ptr quiche_config_1392509373;
      v: bool): void {.cdecl,
                       importc: "quiche_config_set_disable_active_migration".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_disable_active_migration" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_cc_algorithm_name):
  proc quiche_config_set_cc_algorithm_name*(config: ptr quiche_config_1392509373;
      algo: cstring): cint {.cdecl,
                             importc: "quiche_config_set_cc_algorithm_name".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_cc_algorithm_name" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_initial_congestion_window_packets):
  proc quiche_config_set_initial_congestion_window_packets*(
      config: ptr quiche_config_1392509373; packets: csize_t): void {.cdecl,
      importc: "quiche_config_set_initial_congestion_window_packets".}
else:
  static :
    hint("Declaration of " &
        "quiche_config_set_initial_congestion_window_packets" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_cc_algorithm):
  proc quiche_config_set_cc_algorithm*(config: ptr quiche_config_1392509373;
                                       algo: enum_quiche_cc_algorithm_1392509375): void {.
      cdecl, importc: "quiche_config_set_cc_algorithm".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_cc_algorithm" &
        " already exists, not redeclaring")
when not declared(quiche_config_enable_hystart):
  proc quiche_config_enable_hystart*(config: ptr quiche_config_1392509373;
                                     v: bool): void {.cdecl,
      importc: "quiche_config_enable_hystart".}
else:
  static :
    hint("Declaration of " & "quiche_config_enable_hystart" &
        " already exists, not redeclaring")
when not declared(quiche_config_enable_pacing):
  proc quiche_config_enable_pacing*(config: ptr quiche_config_1392509373;
                                    v: bool): void {.cdecl,
      importc: "quiche_config_enable_pacing".}
else:
  static :
    hint("Declaration of " & "quiche_config_enable_pacing" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_pacing_rate):
  proc quiche_config_set_max_pacing_rate*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_max_pacing_rate".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_pacing_rate" &
        " already exists, not redeclaring")
when not declared(quiche_config_enable_dgram):
  proc quiche_config_enable_dgram*(config: ptr quiche_config_1392509373;
                                   enabled: bool; recv_queue_len: csize_t;
                                   send_queue_len: csize_t): void {.cdecl,
      importc: "quiche_config_enable_dgram".}
else:
  static :
    hint("Declaration of " & "quiche_config_enable_dgram" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_connection_window):
  proc quiche_config_set_max_connection_window*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl,
                         importc: "quiche_config_set_max_connection_window".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_connection_window" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_max_stream_window):
  proc quiche_config_set_max_stream_window*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_max_stream_window".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_max_stream_window" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_active_connection_id_limit):
  proc quiche_config_set_active_connection_id_limit*(config: ptr quiche_config_1392509373;
      v: uint64): void {.cdecl, importc: "quiche_config_set_active_connection_id_limit".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_active_connection_id_limit" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_stateless_reset_token):
  proc quiche_config_set_stateless_reset_token*(config: ptr quiche_config_1392509373;
      v: ptr uint8): void {.cdecl,
                            importc: "quiche_config_set_stateless_reset_token".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_stateless_reset_token" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_disable_dcid_reuse):
  proc quiche_config_set_disable_dcid_reuse*(config: ptr quiche_config_1392509373;
      v: bool): void {.cdecl, importc: "quiche_config_set_disable_dcid_reuse".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_disable_dcid_reuse" &
        " already exists, not redeclaring")
when not declared(quiche_config_set_ticket_key):
  proc quiche_config_set_ticket_key*(config: ptr quiche_config_1392509373;
                                     key: ptr uint8; key_len: csize_t): cint {.
      cdecl, importc: "quiche_config_set_ticket_key".}
else:
  static :
    hint("Declaration of " & "quiche_config_set_ticket_key" &
        " already exists, not redeclaring")
when not declared(quiche_config_free):
  proc quiche_config_free*(config: ptr quiche_config_1392509373): void {.cdecl,
      importc: "quiche_config_free".}
else:
  static :
    hint("Declaration of " & "quiche_config_free" &
        " already exists, not redeclaring")
when not declared(quiche_header_info):
  proc quiche_header_info*(buf: ptr uint8; buf_len: csize_t; dcil: csize_t;
                           version: ptr uint32; type_arg: ptr uint8;
                           scid: ptr uint8; scid_len: ptr csize_t;
                           dcid: ptr uint8; dcid_len: ptr csize_t;
                           token: ptr uint8; token_len: ptr csize_t): cint {.
      cdecl, importc: "quiche_header_info".}
else:
  static :
    hint("Declaration of " & "quiche_header_info" &
        " already exists, not redeclaring")
when not declared(quiche_accept):
  proc quiche_accept*(scid: ptr uint8; scid_len: csize_t; odcid: ptr uint8;
                      odcid_len: csize_t; local: ptr struct_sockaddr_1392509379;
                      local_len: socklen_t_1392509381;
                      peer: ptr struct_sockaddr_1392509379; peer_len: socklen_t_1392509381;
                      config: ptr quiche_config_1392509373): ptr quiche_conn_1392509377 {.
      cdecl, importc: "quiche_accept".}
else:
  static :
    hint("Declaration of " & "quiche_accept" &
        " already exists, not redeclaring")
when not declared(quiche_connect):
  proc quiche_connect*(server_name: cstring; scid: ptr uint8; scid_len: csize_t;
                       local: ptr struct_sockaddr_1392509379;
                       local_len: socklen_t_1392509381;
                       peer: ptr struct_sockaddr_1392509379;
                       peer_len: socklen_t_1392509381; config: ptr quiche_config_1392509373): ptr quiche_conn_1392509377 {.
      cdecl, importc: "quiche_connect".}
else:
  static :
    hint("Declaration of " & "quiche_connect" &
        " already exists, not redeclaring")
when not declared(quiche_negotiate_version):
  proc quiche_negotiate_version*(scid: ptr uint8; scid_len: csize_t;
                                 dcid: ptr uint8; dcid_len: csize_t;
                                 out_arg: ptr uint8; out_len: csize_t): ssize_t_1392509383 {.
      cdecl, importc: "quiche_negotiate_version".}
else:
  static :
    hint("Declaration of " & "quiche_negotiate_version" &
        " already exists, not redeclaring")
when not declared(quiche_retry):
  proc quiche_retry*(scid: ptr uint8; scid_len: csize_t; dcid: ptr uint8;
                     dcid_len: csize_t; new_scid: ptr uint8;
                     new_scid_len: csize_t; token: ptr uint8;
                     token_len: csize_t; version: uint32; out_arg: ptr uint8;
                     out_len: csize_t): ssize_t_1392509383 {.cdecl,
      importc: "quiche_retry".}
else:
  static :
    hint("Declaration of " & "quiche_retry" & " already exists, not redeclaring")
when not declared(quiche_version_is_supported):
  proc quiche_version_is_supported*(version: uint32): bool {.cdecl,
      importc: "quiche_version_is_supported".}
else:
  static :
    hint("Declaration of " & "quiche_version_is_supported" &
        " already exists, not redeclaring")
when not declared(quiche_conn_new_with_tls):
  proc quiche_conn_new_with_tls*(scid: ptr uint8; scid_len: csize_t;
                                 odcid: ptr uint8; odcid_len: csize_t;
                                 local: ptr struct_sockaddr_1392509379;
                                 local_len: socklen_t_1392509381;
                                 peer: ptr struct_sockaddr_1392509379;
                                 peer_len: socklen_t_1392509381;
                                 config: ptr quiche_config_1392509373;
                                 ssl: pointer; is_server: bool): ptr quiche_conn_1392509377 {.
      cdecl, importc: "quiche_conn_new_with_tls".}
else:
  static :
    hint("Declaration of " & "quiche_conn_new_with_tls" &
        " already exists, not redeclaring")
when not declared(quiche_conn_set_keylog_path):
  proc quiche_conn_set_keylog_path*(conn: ptr quiche_conn_1392509377;
                                    path: cstring): bool {.cdecl,
      importc: "quiche_conn_set_keylog_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_set_keylog_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_set_keylog_fd):
  proc quiche_conn_set_keylog_fd*(conn: ptr quiche_conn_1392509377; fd: cint): void {.
      cdecl, importc: "quiche_conn_set_keylog_fd".}
else:
  static :
    hint("Declaration of " & "quiche_conn_set_keylog_fd" &
        " already exists, not redeclaring")
when not declared(quiche_conn_set_qlog_path):
  proc quiche_conn_set_qlog_path*(conn: ptr quiche_conn_1392509377;
                                  path: cstring; log_title: cstring;
                                  log_desc: cstring): bool {.cdecl,
      importc: "quiche_conn_set_qlog_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_set_qlog_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_set_qlog_fd):
  proc quiche_conn_set_qlog_fd*(conn: ptr quiche_conn_1392509377; fd: cint;
                                log_title: cstring; log_desc: cstring): void {.
      cdecl, importc: "quiche_conn_set_qlog_fd".}
else:
  static :
    hint("Declaration of " & "quiche_conn_set_qlog_fd" &
        " already exists, not redeclaring")
when not declared(quiche_conn_set_session):
  proc quiche_conn_set_session*(conn: ptr quiche_conn_1392509377;
                                buf: ptr uint8; buf_len: csize_t): cint {.cdecl,
      importc: "quiche_conn_set_session".}
else:
  static :
    hint("Declaration of " & "quiche_conn_set_session" &
        " already exists, not redeclaring")
when not declared(quiche_conn_recv):
  proc quiche_conn_recv*(conn: ptr quiche_conn_1392509377; buf: ptr uint8;
                         buf_len: csize_t; info: ptr quiche_recv_info_1392509387): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_recv".}
else:
  static :
    hint("Declaration of " & "quiche_conn_recv" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send):
  proc quiche_conn_send*(conn: ptr quiche_conn_1392509377; out_arg: ptr uint8;
                         out_len: csize_t; out_info: ptr quiche_send_info_1392509395): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_send".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send_quantum):
  proc quiche_conn_send_quantum*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_send_quantum".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send_quantum" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send_on_path):
  proc quiche_conn_send_on_path*(conn: ptr quiche_conn_1392509377;
                                 out_arg: ptr uint8; out_len: csize_t;
                                 from_arg: ptr struct_sockaddr_1392509379;
                                 from_len: socklen_t_1392509381;
                                 to: ptr struct_sockaddr_1392509379;
                                 to_len: socklen_t_1392509381;
                                 out_info: ptr quiche_send_info_1392509395): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_send_on_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send_on_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send_quantum_on_path):
  proc quiche_conn_send_quantum_on_path*(conn: ptr quiche_conn_1392509377;
      local_addr: ptr struct_sockaddr_1392509379; local_len: socklen_t_1392509381;
      peer_addr: ptr struct_sockaddr_1392509379; peer_len: socklen_t_1392509381): csize_t {.
      cdecl, importc: "quiche_conn_send_quantum_on_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send_quantum_on_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_recv):
  proc quiche_conn_stream_recv*(conn: ptr quiche_conn_1392509377;
                                stream_id: uint64; out_arg: ptr uint8;
                                buf_len: csize_t; fin: ptr bool;
                                out_error_code: ptr uint64): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_stream_recv".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_recv" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_send):
  proc quiche_conn_stream_send*(conn: ptr quiche_conn_1392509377;
                                stream_id: uint64; buf: ptr uint8;
                                buf_len: csize_t; fin: bool;
                                out_error_code: ptr uint64): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_stream_send".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_send" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_priority):
  proc quiche_conn_stream_priority*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64; urgency: uint8;
                                    incremental: bool): cint {.cdecl,
      importc: "quiche_conn_stream_priority".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_priority" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_shutdown):
  proc quiche_conn_stream_shutdown*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64;
                                    direction: enum_quiche_shutdown_1392509397;
                                    err: uint64): cint {.cdecl,
      importc: "quiche_conn_stream_shutdown".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_shutdown" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_capacity):
  proc quiche_conn_stream_capacity*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_stream_capacity".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_capacity" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_readable):
  proc quiche_conn_stream_readable*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64): bool {.cdecl,
      importc: "quiche_conn_stream_readable".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_readable" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_readable_next):
  proc quiche_conn_stream_readable_next*(conn: ptr quiche_conn_1392509377): int64 {.
      cdecl, importc: "quiche_conn_stream_readable_next".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_readable_next" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_writable):
  proc quiche_conn_stream_writable*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64; len: csize_t): cint {.
      cdecl, importc: "quiche_conn_stream_writable".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_writable" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_writable_next):
  proc quiche_conn_stream_writable_next*(conn: ptr quiche_conn_1392509377): int64 {.
      cdecl, importc: "quiche_conn_stream_writable_next".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_writable_next" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stream_finished):
  proc quiche_conn_stream_finished*(conn: ptr quiche_conn_1392509377;
                                    stream_id: uint64): bool {.cdecl,
      importc: "quiche_conn_stream_finished".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stream_finished" &
        " already exists, not redeclaring")
when not declared(quiche_conn_readable):
  proc quiche_conn_readable*(conn: ptr quiche_conn_1392509377): ptr quiche_stream_iter_1392509399 {.
      cdecl, importc: "quiche_conn_readable".}
else:
  static :
    hint("Declaration of " & "quiche_conn_readable" &
        " already exists, not redeclaring")
when not declared(quiche_conn_writable):
  proc quiche_conn_writable*(conn: ptr quiche_conn_1392509377): ptr quiche_stream_iter_1392509399 {.
      cdecl, importc: "quiche_conn_writable".}
else:
  static :
    hint("Declaration of " & "quiche_conn_writable" &
        " already exists, not redeclaring")
when not declared(quiche_conn_max_send_udp_payload_size):
  proc quiche_conn_max_send_udp_payload_size*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_max_send_udp_payload_size".}
else:
  static :
    hint("Declaration of " & "quiche_conn_max_send_udp_payload_size" &
        " already exists, not redeclaring")
when not declared(quiche_conn_timeout_as_nanos):
  proc quiche_conn_timeout_as_nanos*(conn: ptr quiche_conn_1392509377): uint64 {.
      cdecl, importc: "quiche_conn_timeout_as_nanos".}
else:
  static :
    hint("Declaration of " & "quiche_conn_timeout_as_nanos" &
        " already exists, not redeclaring")
when not declared(quiche_conn_timeout_as_millis):
  proc quiche_conn_timeout_as_millis*(conn: ptr quiche_conn_1392509377): uint64 {.
      cdecl, importc: "quiche_conn_timeout_as_millis".}
else:
  static :
    hint("Declaration of " & "quiche_conn_timeout_as_millis" &
        " already exists, not redeclaring")
when not declared(quiche_conn_on_timeout):
  proc quiche_conn_on_timeout*(conn: ptr quiche_conn_1392509377): void {.cdecl,
      importc: "quiche_conn_on_timeout".}
else:
  static :
    hint("Declaration of " & "quiche_conn_on_timeout" &
        " already exists, not redeclaring")
when not declared(quiche_conn_close):
  proc quiche_conn_close*(conn: ptr quiche_conn_1392509377; app: bool;
                          err: uint64; reason: ptr uint8; reason_len: csize_t): cint {.
      cdecl, importc: "quiche_conn_close".}
else:
  static :
    hint("Declaration of " & "quiche_conn_close" &
        " already exists, not redeclaring")
when not declared(quiche_conn_trace_id):
  proc quiche_conn_trace_id*(conn: ptr quiche_conn_1392509377;
                             out_arg: ptr ptr uint8; out_len: ptr csize_t): void {.
      cdecl, importc: "quiche_conn_trace_id".}
else:
  static :
    hint("Declaration of " & "quiche_conn_trace_id" &
        " already exists, not redeclaring")
when not declared(quiche_conn_source_id):
  proc quiche_conn_source_id*(conn: ptr quiche_conn_1392509377;
                              out_arg: ptr ptr uint8; out_len: ptr csize_t): void {.
      cdecl, importc: "quiche_conn_source_id".}
else:
  static :
    hint("Declaration of " & "quiche_conn_source_id" &
        " already exists, not redeclaring")
when not declared(quiche_conn_source_ids):
  proc quiche_conn_source_ids*(conn: ptr quiche_conn_1392509377): ptr quiche_connection_id_iter_1392509401 {.
      cdecl, importc: "quiche_conn_source_ids".}
else:
  static :
    hint("Declaration of " & "quiche_conn_source_ids" &
        " already exists, not redeclaring")
when not declared(quiche_connection_id_iter_next):
  proc quiche_connection_id_iter_next*(iter: ptr quiche_connection_id_iter_1392509401;
                                       out_arg: ptr ptr uint8;
                                       out_len: ptr csize_t): bool {.cdecl,
      importc: "quiche_connection_id_iter_next".}
else:
  static :
    hint("Declaration of " & "quiche_connection_id_iter_next" &
        " already exists, not redeclaring")
when not declared(quiche_connection_id_iter_free):
  proc quiche_connection_id_iter_free*(iter: ptr quiche_connection_id_iter_1392509401): void {.
      cdecl, importc: "quiche_connection_id_iter_free".}
else:
  static :
    hint("Declaration of " & "quiche_connection_id_iter_free" &
        " already exists, not redeclaring")
when not declared(quiche_conn_destination_id):
  proc quiche_conn_destination_id*(conn: ptr quiche_conn_1392509377;
                                   out_arg: ptr ptr uint8; out_len: ptr csize_t): void {.
      cdecl, importc: "quiche_conn_destination_id".}
else:
  static :
    hint("Declaration of " & "quiche_conn_destination_id" &
        " already exists, not redeclaring")
when not declared(quiche_conn_application_proto):
  proc quiche_conn_application_proto*(conn: ptr quiche_conn_1392509377;
                                      out_arg: ptr ptr uint8;
                                      out_len: ptr csize_t): void {.cdecl,
      importc: "quiche_conn_application_proto".}
else:
  static :
    hint("Declaration of " & "quiche_conn_application_proto" &
        " already exists, not redeclaring")
when not declared(quiche_conn_peer_cert):
  proc quiche_conn_peer_cert*(conn: ptr quiche_conn_1392509377;
                              out_arg: ptr ptr uint8; out_len: ptr csize_t): void {.
      cdecl, importc: "quiche_conn_peer_cert".}
else:
  static :
    hint("Declaration of " & "quiche_conn_peer_cert" &
        " already exists, not redeclaring")
when not declared(quiche_conn_session):
  proc quiche_conn_session*(conn: ptr quiche_conn_1392509377;
                            out_arg: ptr ptr uint8; out_len: ptr csize_t): void {.
      cdecl, importc: "quiche_conn_session".}
else:
  static :
    hint("Declaration of " & "quiche_conn_session" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_established):
  proc quiche_conn_is_established*(conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_conn_is_established".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_established" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_resumed):
  proc quiche_conn_is_resumed*(conn: ptr quiche_conn_1392509377): bool {.cdecl,
      importc: "quiche_conn_is_resumed".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_resumed" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_in_early_data):
  proc quiche_conn_is_in_early_data*(conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_conn_is_in_early_data".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_in_early_data" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_readable):
  proc quiche_conn_is_readable*(conn: ptr quiche_conn_1392509377): bool {.cdecl,
      importc: "quiche_conn_is_readable".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_readable" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_draining):
  proc quiche_conn_is_draining*(conn: ptr quiche_conn_1392509377): bool {.cdecl,
      importc: "quiche_conn_is_draining".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_draining" &
        " already exists, not redeclaring")
when not declared(quiche_conn_peer_streams_left_bidi):
  proc quiche_conn_peer_streams_left_bidi*(conn: ptr quiche_conn_1392509377): uint64 {.
      cdecl, importc: "quiche_conn_peer_streams_left_bidi".}
else:
  static :
    hint("Declaration of " & "quiche_conn_peer_streams_left_bidi" &
        " already exists, not redeclaring")
when not declared(quiche_conn_peer_streams_left_uni):
  proc quiche_conn_peer_streams_left_uni*(conn: ptr quiche_conn_1392509377): uint64 {.
      cdecl, importc: "quiche_conn_peer_streams_left_uni".}
else:
  static :
    hint("Declaration of " & "quiche_conn_peer_streams_left_uni" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_closed):
  proc quiche_conn_is_closed*(conn: ptr quiche_conn_1392509377): bool {.cdecl,
      importc: "quiche_conn_is_closed".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_closed" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_timed_out):
  proc quiche_conn_is_timed_out*(conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_conn_is_timed_out".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_timed_out" &
        " already exists, not redeclaring")
when not declared(quiche_conn_peer_error):
  proc quiche_conn_peer_error*(conn: ptr quiche_conn_1392509377;
                               is_app: ptr bool; error_code: ptr uint64;
                               reason: ptr ptr uint8; reason_len: ptr csize_t): bool {.
      cdecl, importc: "quiche_conn_peer_error".}
else:
  static :
    hint("Declaration of " & "quiche_conn_peer_error" &
        " already exists, not redeclaring")
when not declared(quiche_conn_local_error):
  proc quiche_conn_local_error*(conn: ptr quiche_conn_1392509377;
                                is_app: ptr bool; error_code: ptr uint64;
                                reason: ptr ptr uint8; reason_len: ptr csize_t): bool {.
      cdecl, importc: "quiche_conn_local_error".}
else:
  static :
    hint("Declaration of " & "quiche_conn_local_error" &
        " already exists, not redeclaring")
when not declared(quiche_stream_iter_next):
  proc quiche_stream_iter_next*(iter: ptr quiche_stream_iter_1392509399;
                                stream_id: ptr uint64): bool {.cdecl,
      importc: "quiche_stream_iter_next".}
else:
  static :
    hint("Declaration of " & "quiche_stream_iter_next" &
        " already exists, not redeclaring")
when not declared(quiche_stream_iter_free):
  proc quiche_stream_iter_free*(iter: ptr quiche_stream_iter_1392509399): void {.
      cdecl, importc: "quiche_stream_iter_free".}
else:
  static :
    hint("Declaration of " & "quiche_stream_iter_free" &
        " already exists, not redeclaring")
when not declared(quiche_conn_stats):
  proc quiche_conn_stats*(conn: ptr quiche_conn_1392509377;
                          out_arg: ptr quiche_stats_1392509405): void {.cdecl,
      importc: "quiche_conn_stats".}
else:
  static :
    hint("Declaration of " & "quiche_conn_stats" &
        " already exists, not redeclaring")
when not declared(quiche_conn_peer_transport_params):
  proc quiche_conn_peer_transport_params*(conn: ptr quiche_conn_1392509377;
      out_arg: ptr quiche_transport_params_1392509409): bool {.cdecl,
      importc: "quiche_conn_peer_transport_params".}
else:
  static :
    hint("Declaration of " & "quiche_conn_peer_transport_params" &
        " already exists, not redeclaring")
when not declared(quiche_conn_path_stats):
  proc quiche_conn_path_stats*(conn: ptr quiche_conn_1392509377; idx: csize_t;
                               out_arg: ptr quiche_path_stats_1392509413): cint {.
      cdecl, importc: "quiche_conn_path_stats".}
else:
  static :
    hint("Declaration of " & "quiche_conn_path_stats" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_server):
  proc quiche_conn_is_server*(conn: ptr quiche_conn_1392509377): bool {.cdecl,
      importc: "quiche_conn_is_server".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_server" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_max_writable_len):
  proc quiche_conn_dgram_max_writable_len*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_max_writable_len".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_max_writable_len" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_recv_front_len):
  proc quiche_conn_dgram_recv_front_len*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_recv_front_len".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_recv_front_len" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_recv_queue_len):
  proc quiche_conn_dgram_recv_queue_len*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_recv_queue_len".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_recv_queue_len" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_recv_queue_byte_size):
  proc quiche_conn_dgram_recv_queue_byte_size*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_recv_queue_byte_size".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_recv_queue_byte_size" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_send_queue_len):
  proc quiche_conn_dgram_send_queue_len*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_send_queue_len".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_send_queue_len" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_send_queue_byte_size):
  proc quiche_conn_dgram_send_queue_byte_size*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_dgram_send_queue_byte_size".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_send_queue_byte_size" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_recv):
  proc quiche_conn_dgram_recv*(conn: ptr quiche_conn_1392509377; buf: ptr uint8;
                               buf_len: csize_t): ssize_t_1392509383 {.cdecl,
      importc: "quiche_conn_dgram_recv".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_recv" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_send):
  proc quiche_conn_dgram_send*(conn: ptr quiche_conn_1392509377; buf: ptr uint8;
                               buf_len: csize_t): ssize_t_1392509383 {.cdecl,
      importc: "quiche_conn_dgram_send".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_send" &
        " already exists, not redeclaring")
when not declared(quiche_conn_dgram_purge_outgoing):
  proc quiche_conn_dgram_purge_outgoing*(conn: ptr quiche_conn_1392509377;
      f: proc (a0: ptr uint8; a1: csize_t): bool {.cdecl.}): void {.cdecl,
      importc: "quiche_conn_dgram_purge_outgoing".}
else:
  static :
    hint("Declaration of " & "quiche_conn_dgram_purge_outgoing" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_dgram_send_queue_full):
  proc quiche_conn_is_dgram_send_queue_full*(conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_conn_is_dgram_send_queue_full".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_dgram_send_queue_full" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_dgram_recv_queue_full):
  proc quiche_conn_is_dgram_recv_queue_full*(conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_conn_is_dgram_recv_queue_full".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_dgram_recv_queue_full" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send_ack_eliciting):
  proc quiche_conn_send_ack_eliciting*(conn: ptr quiche_conn_1392509377): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_send_ack_eliciting".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send_ack_eliciting" &
        " already exists, not redeclaring")
when not declared(quiche_conn_send_ack_eliciting_on_path):
  proc quiche_conn_send_ack_eliciting_on_path*(conn: ptr quiche_conn_1392509377;
      local: ptr struct_sockaddr_1392509379; local_len: socklen_t_1392509381;
      peer: ptr struct_sockaddr_1392509379; peer_len: socklen_t_1392509381): ssize_t_1392509383 {.
      cdecl, importc: "quiche_conn_send_ack_eliciting_on_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_send_ack_eliciting_on_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_retired_scid_next):
  proc quiche_conn_retired_scid_next*(conn: ptr quiche_conn_1392509377;
                                      out_arg: ptr ptr uint8;
                                      out_len: ptr csize_t): bool {.cdecl,
      importc: "quiche_conn_retired_scid_next".}
else:
  static :
    hint("Declaration of " & "quiche_conn_retired_scid_next" &
        " already exists, not redeclaring")
when not declared(quiche_conn_retired_scids):
  proc quiche_conn_retired_scids*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_retired_scids".}
else:
  static :
    hint("Declaration of " & "quiche_conn_retired_scids" &
        " already exists, not redeclaring")
when not declared(quiche_conn_available_dcids):
  proc quiche_conn_available_dcids*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_available_dcids".}
else:
  static :
    hint("Declaration of " & "quiche_conn_available_dcids" &
        " already exists, not redeclaring")
when not declared(quiche_conn_scids_left):
  proc quiche_conn_scids_left*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_scids_left".}
else:
  static :
    hint("Declaration of " & "quiche_conn_scids_left" &
        " already exists, not redeclaring")
when not declared(quiche_conn_active_scids):
  proc quiche_conn_active_scids*(conn: ptr quiche_conn_1392509377): csize_t {.
      cdecl, importc: "quiche_conn_active_scids".}
else:
  static :
    hint("Declaration of " & "quiche_conn_active_scids" &
        " already exists, not redeclaring")
when not declared(quiche_conn_new_scid):
  proc quiche_conn_new_scid*(conn: ptr quiche_conn_1392509377; scid: ptr uint8;
                             scid_len: csize_t; reset_token: ptr uint8;
                             retire_if_needed: bool; scid_seq: ptr uint64): cint {.
      cdecl, importc: "quiche_conn_new_scid".}
else:
  static :
    hint("Declaration of " & "quiche_conn_new_scid" &
        " already exists, not redeclaring")
when not declared(quiche_conn_probe_path):
  proc quiche_conn_probe_path*(conn: ptr quiche_conn_1392509377;
                               local: ptr struct_sockaddr_1392509379;
                               local_len: socklen_t_1392509381;
                               peer: ptr struct_sockaddr_1392509379;
                               peer_len: socklen_t_1392509381; seq: ptr uint64): cint {.
      cdecl, importc: "quiche_conn_probe_path".}
else:
  static :
    hint("Declaration of " & "quiche_conn_probe_path" &
        " already exists, not redeclaring")
when not declared(quiche_conn_migrate_source):
  proc quiche_conn_migrate_source*(conn: ptr quiche_conn_1392509377;
                                   local: ptr struct_sockaddr_1392509379;
                                   local_len: socklen_t_1392509381;
                                   seq: ptr uint64): cint {.cdecl,
      importc: "quiche_conn_migrate_source".}
else:
  static :
    hint("Declaration of " & "quiche_conn_migrate_source" &
        " already exists, not redeclaring")
when not declared(quiche_conn_migrate):
  proc quiche_conn_migrate*(conn: ptr quiche_conn_1392509377;
                            local: ptr struct_sockaddr_1392509379;
                            local_len: socklen_t_1392509381;
                            peer: ptr struct_sockaddr_1392509379;
                            peer_len: socklen_t_1392509381; seq: ptr uint64): cint {.
      cdecl, importc: "quiche_conn_migrate".}
else:
  static :
    hint("Declaration of " & "quiche_conn_migrate" &
        " already exists, not redeclaring")
when not declared(quiche_conn_path_event_next):
  proc quiche_conn_path_event_next*(conn: ptr quiche_conn_1392509377): ptr quiche_path_event_1392509417 {.
      cdecl, importc: "quiche_conn_path_event_next".}
else:
  static :
    hint("Declaration of " & "quiche_conn_path_event_next" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_type):
  proc quiche_path_event_type*(ev: ptr quiche_path_event_1392509417): enum_quiche_path_event_type_1392509415 {.
      cdecl, importc: "quiche_path_event_type".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_type" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_new):
  proc quiche_path_event_new*(ev: ptr quiche_path_event_1392509417;
                              local: ptr struct_sockaddr_storage_1392509391;
                              local_len: ptr socklen_t_1392509381;
                              peer: ptr struct_sockaddr_storage_1392509391;
                              peer_len: ptr socklen_t_1392509381): void {.cdecl,
      importc: "quiche_path_event_new".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_new" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_validated):
  proc quiche_path_event_validated*(ev: ptr quiche_path_event_1392509417;
                                    local: ptr struct_sockaddr_storage_1392509391;
                                    local_len: ptr socklen_t_1392509381;
                                    peer: ptr struct_sockaddr_storage_1392509391;
                                    peer_len: ptr socklen_t_1392509381): void {.
      cdecl, importc: "quiche_path_event_validated".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_validated" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_failed_validation):
  proc quiche_path_event_failed_validation*(ev: ptr quiche_path_event_1392509417;
      local: ptr struct_sockaddr_storage_1392509391; local_len: ptr socklen_t_1392509381;
      peer: ptr struct_sockaddr_storage_1392509391; peer_len: ptr socklen_t_1392509381): void {.
      cdecl, importc: "quiche_path_event_failed_validation".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_failed_validation" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_closed):
  proc quiche_path_event_closed*(ev: ptr quiche_path_event_1392509417;
                                 local: ptr struct_sockaddr_storage_1392509391;
                                 local_len: ptr socklen_t_1392509381;
                                 peer: ptr struct_sockaddr_storage_1392509391;
                                 peer_len: ptr socklen_t_1392509381): void {.
      cdecl, importc: "quiche_path_event_closed".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_closed" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_reused_source_connection_id):
  proc quiche_path_event_reused_source_connection_id*(ev: ptr quiche_path_event_1392509417;
      id: ptr uint64; old_local: ptr struct_sockaddr_storage_1392509391;
      old_local_len: ptr socklen_t_1392509381;
      old_peer: ptr struct_sockaddr_storage_1392509391;
      old_peer_len: ptr socklen_t_1392509381;
      local: ptr struct_sockaddr_storage_1392509391; local_len: ptr socklen_t_1392509381;
      peer: ptr struct_sockaddr_storage_1392509391; peer_len: ptr socklen_t_1392509381): void {.
      cdecl, importc: "quiche_path_event_reused_source_connection_id".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_reused_source_connection_id" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_peer_migrated):
  proc quiche_path_event_peer_migrated*(ev: ptr quiche_path_event_1392509417;
                                        local: ptr struct_sockaddr_storage_1392509391;
                                        local_len: ptr socklen_t_1392509381;
                                        peer: ptr struct_sockaddr_storage_1392509391;
                                        peer_len: ptr socklen_t_1392509381): void {.
      cdecl, importc: "quiche_path_event_peer_migrated".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_peer_migrated" &
        " already exists, not redeclaring")
when not declared(quiche_path_event_free):
  proc quiche_path_event_free*(ev: ptr quiche_path_event_1392509417): void {.
      cdecl, importc: "quiche_path_event_free".}
else:
  static :
    hint("Declaration of " & "quiche_path_event_free" &
        " already exists, not redeclaring")
when not declared(quiche_conn_retire_dcid):
  proc quiche_conn_retire_dcid*(conn: ptr quiche_conn_1392509377;
                                dcid_seq: uint64): cint {.cdecl,
      importc: "quiche_conn_retire_dcid".}
else:
  static :
    hint("Declaration of " & "quiche_conn_retire_dcid" &
        " already exists, not redeclaring")
when not declared(quiche_conn_paths_iter):
  proc quiche_conn_paths_iter*(conn: ptr quiche_conn_1392509377;
                               from_arg: ptr struct_sockaddr_1392509379;
                               from_len: csize_t): ptr quiche_socket_addr_iter_1392509419 {.
      cdecl, importc: "quiche_conn_paths_iter".}
else:
  static :
    hint("Declaration of " & "quiche_conn_paths_iter" &
        " already exists, not redeclaring")
when not declared(quiche_socket_addr_iter_next):
  proc quiche_socket_addr_iter_next*(iter: ptr quiche_socket_addr_iter_1392509419;
                                     peer: ptr struct_sockaddr_storage_1392509391;
                                     peer_len: ptr csize_t): bool {.cdecl,
      importc: "quiche_socket_addr_iter_next".}
else:
  static :
    hint("Declaration of " & "quiche_socket_addr_iter_next" &
        " already exists, not redeclaring")
when not declared(quiche_socket_addr_iter_free):
  proc quiche_socket_addr_iter_free*(iter: ptr quiche_socket_addr_iter_1392509419): void {.
      cdecl, importc: "quiche_socket_addr_iter_free".}
else:
  static :
    hint("Declaration of " & "quiche_socket_addr_iter_free" &
        " already exists, not redeclaring")
when not declared(quiche_conn_is_path_validated):
  proc quiche_conn_is_path_validated*(conn: ptr quiche_conn_1392509377;
                                      from_arg: ptr struct_sockaddr_1392509379;
                                      from_len: csize_t;
                                      to: ptr struct_sockaddr_1392509379;
                                      to_len: csize_t): cint {.cdecl,
      importc: "quiche_conn_is_path_validated".}
else:
  static :
    hint("Declaration of " & "quiche_conn_is_path_validated" &
        " already exists, not redeclaring")
when not declared(quiche_conn_free):
  proc quiche_conn_free*(conn: ptr quiche_conn_1392509377): void {.cdecl,
      importc: "quiche_conn_free".}
else:
  static :
    hint("Declaration of " & "quiche_conn_free" &
        " already exists, not redeclaring")
when not declared(quiche_put_varint):
  proc quiche_put_varint*(buf: ptr uint8; buf_len: csize_t; val: uint64): cint {.
      cdecl, importc: "quiche_put_varint".}
else:
  static :
    hint("Declaration of " & "quiche_put_varint" &
        " already exists, not redeclaring")
when not declared(quiche_get_varint):
  proc quiche_get_varint*(buf: ptr uint8; buf_len: csize_t; val: ptr uint64): ssize_t_1392509383 {.
      cdecl, importc: "quiche_get_varint".}
else:
  static :
    hint("Declaration of " & "quiche_get_varint" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_new):
  proc quiche_h3_config_new*(): ptr quiche_h3_config_1392509423 {.cdecl,
      importc: "quiche_h3_config_new".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_new" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_set_max_field_section_size):
  proc quiche_h3_config_set_max_field_section_size*(
      config: ptr quiche_h3_config_1392509423; v: uint64): void {.cdecl,
      importc: "quiche_h3_config_set_max_field_section_size".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_set_max_field_section_size" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_set_qpack_max_table_capacity):
  proc quiche_h3_config_set_qpack_max_table_capacity*(
      config: ptr quiche_h3_config_1392509423; v: uint64): void {.cdecl,
      importc: "quiche_h3_config_set_qpack_max_table_capacity".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_set_qpack_max_table_capacity" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_set_qpack_blocked_streams):
  proc quiche_h3_config_set_qpack_blocked_streams*(config: ptr quiche_h3_config_1392509423;
      v: uint64): void {.cdecl,
                         importc: "quiche_h3_config_set_qpack_blocked_streams".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_set_qpack_blocked_streams" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_enable_extended_connect):
  proc quiche_h3_config_enable_extended_connect*(config: ptr quiche_h3_config_1392509423;
      enabled: bool): void {.cdecl, importc: "quiche_h3_config_enable_extended_connect".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_enable_extended_connect" &
        " already exists, not redeclaring")
when not declared(quiche_h3_config_free):
  proc quiche_h3_config_free*(config: ptr quiche_h3_config_1392509423): void {.
      cdecl, importc: "quiche_h3_config_free".}
else:
  static :
    hint("Declaration of " & "quiche_h3_config_free" &
        " already exists, not redeclaring")
when not declared(quiche_h3_conn_new_with_transport):
  proc quiche_h3_conn_new_with_transport*(quiche_conn: ptr quiche_conn_1392509377;
      config: ptr quiche_h3_config_1392509423): ptr quiche_h3_conn_1392509425 {.
      cdecl, importc: "quiche_h3_conn_new_with_transport".}
else:
  static :
    hint("Declaration of " & "quiche_h3_conn_new_with_transport" &
        " already exists, not redeclaring")
when not declared(quiche_h3_conn_poll):
  proc quiche_h3_conn_poll*(conn: ptr quiche_h3_conn_1392509425;
                            quic_conn: ptr quiche_conn_1392509377;
                            ev: ptr ptr quiche_h3_event_1392509429): int64 {.
      cdecl, importc: "quiche_h3_conn_poll".}
else:
  static :
    hint("Declaration of " & "quiche_h3_conn_poll" &
        " already exists, not redeclaring")
when not declared(quiche_h3_event_type):
  proc quiche_h3_event_type*(ev: ptr quiche_h3_event_1392509429): enum_quiche_h3_event_type_1392509427 {.
      cdecl, importc: "quiche_h3_event_type".}
else:
  static :
    hint("Declaration of " & "quiche_h3_event_type" &
        " already exists, not redeclaring")
when not declared(quiche_h3_event_for_each_header):
  proc quiche_h3_event_for_each_header*(ev: ptr quiche_h3_event_1392509429; cb: proc (
      a0: ptr uint8; a1: csize_t; a2: ptr uint8; a3: csize_t; a4: pointer): cint {.
      cdecl.}; argp: pointer): cint {.cdecl, importc: "quiche_h3_event_for_each_header".}
else:
  static :
    hint("Declaration of " & "quiche_h3_event_for_each_header" &
        " already exists, not redeclaring")
when not declared(quiche_h3_for_each_setting):
  proc quiche_h3_for_each_setting*(conn: ptr quiche_h3_conn_1392509425; cb: proc (
      a0: uint64; a1: uint64; a2: pointer): cint {.cdecl.}; argp: pointer): cint {.
      cdecl, importc: "quiche_h3_for_each_setting".}
else:
  static :
    hint("Declaration of " & "quiche_h3_for_each_setting" &
        " already exists, not redeclaring")
when not declared(quiche_h3_event_headers_has_body):
  proc quiche_h3_event_headers_has_body*(ev: ptr quiche_h3_event_1392509429): bool {.
      cdecl, importc: "quiche_h3_event_headers_has_body".}
else:
  static :
    hint("Declaration of " & "quiche_h3_event_headers_has_body" &
        " already exists, not redeclaring")
when not declared(quiche_h3_extended_connect_enabled_by_peer):
  proc quiche_h3_extended_connect_enabled_by_peer*(conn: ptr quiche_h3_conn_1392509425): bool {.
      cdecl, importc: "quiche_h3_extended_connect_enabled_by_peer".}
else:
  static :
    hint("Declaration of " & "quiche_h3_extended_connect_enabled_by_peer" &
        " already exists, not redeclaring")
when not declared(quiche_h3_event_free):
  proc quiche_h3_event_free*(ev: ptr quiche_h3_event_1392509429): void {.cdecl,
      importc: "quiche_h3_event_free".}
else:
  static :
    hint("Declaration of " & "quiche_h3_event_free" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_request):
  proc quiche_h3_send_request*(conn: ptr quiche_h3_conn_1392509425;
                               quic_conn: ptr quiche_conn_1392509377;
                               headers: ptr quiche_h3_header_1392509433;
                               headers_len: csize_t; fin: bool): int64 {.cdecl,
      importc: "quiche_h3_send_request".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_request" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_response):
  proc quiche_h3_send_response*(conn: ptr quiche_h3_conn_1392509425;
                                quic_conn: ptr quiche_conn_1392509377;
                                stream_id: uint64;
                                headers: ptr quiche_h3_header_1392509433;
                                headers_len: csize_t; fin: bool): cint {.cdecl,
      importc: "quiche_h3_send_response".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_response" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_response_with_priority):
  proc quiche_h3_send_response_with_priority*(conn: ptr quiche_h3_conn_1392509425;
      quic_conn: ptr quiche_conn_1392509377; stream_id: uint64;
      headers: ptr quiche_h3_header_1392509433; headers_len: csize_t;
      priority: ptr quiche_h3_priority_1392509437; fin: bool): cint {.cdecl,
      importc: "quiche_h3_send_response_with_priority".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_response_with_priority" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_body):
  proc quiche_h3_send_body*(conn: ptr quiche_h3_conn_1392509425;
                            quic_conn: ptr quiche_conn_1392509377;
                            stream_id: uint64; body: ptr uint8;
                            body_len: csize_t; fin: bool): ssize_t_1392509383 {.
      cdecl, importc: "quiche_h3_send_body".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_body" &
        " already exists, not redeclaring")
when not declared(quiche_h3_recv_body):
  proc quiche_h3_recv_body*(conn: ptr quiche_h3_conn_1392509425;
                            quic_conn: ptr quiche_conn_1392509377;
                            stream_id: uint64; out_arg: ptr uint8;
                            out_len: csize_t): ssize_t_1392509383 {.cdecl,
      importc: "quiche_h3_recv_body".}
else:
  static :
    hint("Declaration of " & "quiche_h3_recv_body" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_goaway):
  proc quiche_h3_send_goaway*(conn: ptr quiche_h3_conn_1392509425;
                              quic_conn: ptr quiche_conn_1392509377; id: uint64): cint {.
      cdecl, importc: "quiche_h3_send_goaway".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_goaway" &
        " already exists, not redeclaring")
when not declared(quiche_h3_parse_extensible_priority):
  proc quiche_h3_parse_extensible_priority*(priority: ptr uint8;
      priority_len: csize_t; parsed: ptr quiche_h3_priority_1392509437): cint {.
      cdecl, importc: "quiche_h3_parse_extensible_priority".}
else:
  static :
    hint("Declaration of " & "quiche_h3_parse_extensible_priority" &
        " already exists, not redeclaring")
when not declared(quiche_h3_send_priority_update_for_request):
  proc quiche_h3_send_priority_update_for_request*(conn: ptr quiche_h3_conn_1392509425;
      quic_conn: ptr quiche_conn_1392509377; stream_id: uint64;
      priority: ptr quiche_h3_priority_1392509437): cint {.cdecl,
      importc: "quiche_h3_send_priority_update_for_request".}
else:
  static :
    hint("Declaration of " & "quiche_h3_send_priority_update_for_request" &
        " already exists, not redeclaring")
when not declared(quiche_h3_take_last_priority_update):
  proc quiche_h3_take_last_priority_update*(conn: ptr quiche_h3_conn_1392509425;
      prioritized_element_id: uint64;
      cb: proc (a0: ptr uint8; a1: uint64; a2: pointer): cint {.cdecl.};
      argp: pointer): cint {.cdecl,
                             importc: "quiche_h3_take_last_priority_update".}
else:
  static :
    hint("Declaration of " & "quiche_h3_take_last_priority_update" &
        " already exists, not redeclaring")
when not declared(quiche_h3_dgram_enabled_by_peer):
  proc quiche_h3_dgram_enabled_by_peer*(conn: ptr quiche_h3_conn_1392509425;
                                        quic_conn: ptr quiche_conn_1392509377): bool {.
      cdecl, importc: "quiche_h3_dgram_enabled_by_peer".}
else:
  static :
    hint("Declaration of " & "quiche_h3_dgram_enabled_by_peer" &
        " already exists, not redeclaring")
when not declared(quiche_h3_conn_free):
  proc quiche_h3_conn_free*(conn: ptr quiche_h3_conn_1392509425): void {.cdecl,
      importc: "quiche_h3_conn_free".}
else:
  static :
    hint("Declaration of " & "quiche_h3_conn_free" &
        " already exists, not redeclaring")