import std/nativesockets
import std/options

import ffi
import config
import errors
export errors

type
  QuicheConnection* = object
    internal: ptr struct_quiche_conn

  RecvInfo* = object
    from_addr*: ptr SockAddr
    from_len*: SockLen
    to_addr*: ptr SockAddr
    to_len*: SockLen

  SendInfo* = object
    from_addr*: Sockaddr_storage
    from_len*: SockLen
    to_addr*: Sockaddr_storage
    to_len*: SockLen

  ShutdownDirection* = enum
    Read = 0,
    Write = 1

  ConnErrorInfo* = object
    is_app: bool
    error_code: uint64
    reason: string

  StreamIterator = object
    internal: ptr struct_quiche_stream_iter

  ConnectionIdIterator = object
    internal: ptr struct_quiche_connection_id_iter


proc `=destroy`*(conn: QuicheConnection) =
  if conn.internal != nil:
    quiche_conn_free(conn.internal)

proc `=destroy`*(it: StreamIterator) =
  if it.internal != nil:
    quiche_stream_iter_free(it.internal)

proc `=destroy`*(it: ConnectionIdIterator) =
  if it.internal != nil:
    quiche_connection_id_iter_free(it.internal)

proc copyToString(buf: ptr uint8, len: csize_t): string =
  var s = newString(len)
  copyMem(s[0].addr, buf, len)
  s

proc copyToSeq(buf: ptr uint8, len: csize_t): seq[uint8] =
  var s: seq[uint8]
  newSeq(s, len)
  copyMem(s[0].addr, buf, len) 
  s

iterator ids(it: StreamIterator): uint64 =
  var id: uint64
  while quiche_stream_iter_next(it.internal, id.addr):
    yield id

iterator ids(it: ConnectionIdIterator): string =
  var id_handle: ptr uint8
  var id_len: csize_t
  while quiche_connection_id_iter_next(it.internal, id_handle.addr, id_len.addr):
    yield copyToString(id_handle, id_len)

## Creates a new server-side connection.
proc accept*(
  scid: openArray[uint8],
  odcid: openArray[uint8],
  local: SockAddr,
  localLen: SockLen,
  peer: SockAddr,
  peerLen: SockLen,
  config: QuicheConfig
): QuicheConnection =
  var raw = quiche_accept(
    scid[0].addr,
    csize_t(scid.len),
    odcid[0].addr,
    csize_t(odcid.len),
    cast[ptr struct_sockaddr](local.addr),
    localLen,
    cast[ptr struct_sockaddr](peer.addr),
    peerLen,
    config.internal,
  )
  QuicheConnection(internal: raw)


## Creates a new client-side connection.
proc connect*(
  server_name: string,
  scid: openArray[uint8],
  local: ptr SockAddr,
  localLen: SockLen,
  peer: ptr SockAddr,
  peerLen: SockLen,
  config: QuicheConfig
): QuicheConnection =
  var raw = quiche_connect(
    cstring(server_name),
    scid[0].addr,
    csize_t(scid.len),
    cast[ptr struct_sockaddr](local),
    localLen,
    cast[ptr struct_sockaddr](peer),
    peerLen,
    config.internal, 
  )
  QuicheConnection(internal: raw)

## Writes a version negotiation packet.
proc negotiate_version*(
  scid: openArray[uint8],
  dcid: openArray[uint8],
  out_buf: openArray[uint8]
): SizeResult = quiche_negotiate_version(
    scid[0].addr,
    csize_t(scid.len),
    dcid[0].addr,
    csize_t(dcid.len),
    out_buf[0].addr,
    csize_t(out_buf.len)
  ).toSizeResult()

## Writes a retry packet.
proc retry*(
  scid: openArray[uint8],
  dcid: openArray[uint8],
  new_scid: openArray[uint8],
  token: openArray[uint8],
  version: uint32,
  out_buf: openArray[uint8]
): SizeResult =
  quiche_retry(
    scid[0].addr,
    csize_t(scid.len),
    dcid[0].addr,
    csize_t(dcid.len),
    new_scid[0].addr,
    csize_t(new_scid.len),
    token[0].addr,
    csize_t(token.len),
    version,
    out_buf[0].addr,
    csize_t(out_buf.len)
  ).toSizeResult()

# TODO: wrap `quiche_conn_new_with_tls` - tricky since it takes a `void *` to a `tls::Handshake` struct - not sure how to constructo one.

## Enables keylog to the specified file path. Returns true on success.
proc set_keylog_path*(conn: QuicheConnection, path: string): bool =
  quiche_conn_set_keylog_path(conn.internal, cstring(path))

## Enables keylog to the specified file descriptor. Unix only.
proc set_keylog_fd*(conn: QuicheConnection, fd: int) =
  quiche_conn_set_keylog_fd(conn.internal, cint(fd))

## Enables qlog to the specified file path. Returns true on success.
proc set_qlog_path*(conn: QuicheConnection, path: string, log_title: string, log_desc: string): bool =
  quiche_conn_set_qlog_path(conn.internal, cstring(path), cstring(log_title), cstring(log_desc))

## Enables qlog to the specified file descriptor. Unix only.
proc set_qlog_fd*(conn: QuicheConnection, fd: int, log_title: string, log_desc: string) =
  quiche_conn_set_qlog_fd(conn.internal, cint(fd), cstring(log_title), cstring(log_desc))

## Configures the given session for resumption.
proc set_session*(conn: QuicheConnection, buf: openArray[uint8]): int =
  quiche_conn_set_session(conn.internal, buf[0].addr, csize_t(buf.len))

## Converts a `RecvInfo` object to a `struct quiche_recv_info`
proc unwrap_recv_info(info: RecvInfo): struct_quiche_recv_info =
  struct_quiche_recv_info(
    from_field: cast[ptr struct_sockaddr](info.from_addr), 
    from_len: info.from_len,
    to: cast[ptr struct_sockaddr](info.to_addr),
    to_len: info.to_len)

## Converts a `struct quiche_send_info` to a `SendInfo` object
proc wrap_send_info(info: struct_quiche_send_info): SendInfo =
  SendInfo(
    from_addr: cast[Sockaddr_storage](info.from_field),
    from_len: cast[SockLen](info.from_len),
    to_addr: cast[Sockaddr_storage](info.to),
    to_len: cast[SockLen](info.to_len)
  )

## Processes QUIC packets received from the peer.
proc recv*(conn: QuicheConnection, packet: openArray[uint8], info: RecvInfo): SizeResult =
  var info_struct = unwrap_recv_info(info)
  quiche_conn_recv(conn.internal, packet[0].addr, csize_t(packet.len), info_struct.addr).toSizeResult()

## Writes a single QUIC packet to be sent to the peer.
proc send*(
  conn: QuicheConnection, 
  packet_out: openArray[uint8], 
  out_info: var SendInfo): SizeResult =
  var send_info: struct_quiche_send_info
  var res = quiche_conn_send(
    conn.internal,
    packet_out[0].addr,
    csize_t(packet_out.len),
    send_info.addr).toSizeResult()
  out_info = wrap_send_info(send_info)
  res

## Returns the size of the send quantum, in bytes.
proc send_quantum*(conn: QuicheConnection): csize_t =
  quiche_conn_send_quantum(conn.internal)

## Writes a single QUIC packet to be sent to the peer from the specified
## local address "from" to the destination address "to".
proc send_on_path*(
  conn: QuicheConnection,
  packet_out: openArray[uint8],
  from_addr: ptr SockAddr,
  from_len: SockLen,
  to_addr: ptr SockAddr,
  to_len: SockLen,
  out_info: var SendInfo): SizeResult =
  var send_info: struct_quiche_send_info
  var res = quiche_conn_send_on_path(
    conn.internal,
    packet_out[0].addr,
    csize_t(packet_out.len),
    cast[ptr struct_sockaddr](from_addr),
    from_len,
    cast[ptr struct_sockaddr](to_addr),
    to_len,
    send_info.addr
  ).toSizeResult()
  out_info = wrap_send_info(send_info)
  res

## Returns the size of the send quantum over the given 4-tuple, in bytes.
proc send_quantum_on_path*(
  conn: QuicheConnection,
  local_addr: ptr SockAddr,
  local_len: SockLen,
  peer_addr: ptr SockAddr,
  peer_len: SockLen
): csize_t =
  quiche_conn_send_quantum_on_path(
    conn.internal,
    cast[ptr struct_sockaddr](local_addr),
    local_len,
    cast[ptr struct_sockaddr](peer_addr),
    peer_len)

## Reads contiguous data from a stream.
## out_error_code is only set when STREAM_STOPPED or STREAM_RESET are returned.
## Set to the reported error code associated with STOP_SENDING or STREAM_RESET.
proc stream_recv*(
  conn: QuicheConnection,
  stream_id: uint64,
  out_buf: openArray[uint8],
  fin: var bool,
  out_error_code: var uint64
): SizeResult =
  quiche_conn_stream_recv(
    conn.internal,
    stream_id,
    out_buf[0].addr,
    csize_t(out_buf.len),
    fin.addr,
    out_error_code.addr,
  ).toSizeResult()

## Writes data to a stream.
## out_error_code is only set when STREAM_STOPPED or STREAM_RESET are returned.
## Set to the reported error code associated with STOP_SENDING or STREAM_RESET. 
proc stream_send*(
  conn: QuicheConnection,
  stream_id: uint64,
  buf: openArray[uint8],
  fin: bool,
  out_error_code: var uint64
): SizeResult =
  quiche_conn_stream_send(
    conn.internal,
    stream_id,
    buf[0].addr,
    csize_t(buf.len),
    fin,
    out_error_code.addr
  ).toSizeResult()

## Sets the priority for a stream
proc stream_priority*(conn: QuicheConnection, stream_id: uint64, urgency: uint8, incremental: bool): QuicheResult =
  quiche_conn_stream_priority(conn.internal, stream_id, urgency, incremental).toQuicheResult()

## Shuts down reading or writing from/to the specified stream.
proc stream_shutdown*(conn: QuicheConnection, stream_id: uint64, direction: ShutdownDirection, err: uint64): QuicheResult =
  quiche_conn_stream_shutdown(conn.internal, stream_id, enum_quiche_shutdown(ord(direction)), err).toQuicheResult()

## Returns the stream's send capacity in bytes.
proc stream_capacity*(conn: QuicheConnection, stream_id: uint64): SizeResult =
  quiche_conn_stream_capacity(conn.internal, stream_id).toSizeResult()

## Returns true if the stream has data that can be read.
proc stream_readable*(conn: QuicheConnection, stream_id: uint64): bool =
  quiche_conn_stream_readable(conn.internal, stream_id)

proc toOptionalStreamId*(id: int64): Option[uint64] =
  if id < 0:
    none(uint64)
  else:
    some(uint64(id))

## Returns the next stream that has data to read, or `none` if no such stream is available.
proc stream_readable_next*(conn: QuicheConnection): Option[uint64] =
  quiche_conn_stream_readable_next(conn.internal).toOptionalStreamId()

## Returns true is the stream has enough send capacity.
proc stream_writable*(conn: QuicheConnection, stream_id: uint64, len: csize_t): BoolResult =
  quiche_conn_stream_writable(conn.internal, stream_id, len).toBoolResult()

## Returns the next stream that can be written to, or `none` if no such stream is available.
proc stream_writable_next*(conn: QuicheConnection): Option[uint64] =
  quiche_conn_stream_writable_next(conn.internal).toOptionalStreamId()

## Returns true if all the data has been read from the specified stream.
proc stream_finished*(conn: QuicheConnection, stream_id: uint64): bool =
  quiche_conn_stream_finished(conn.internal, stream_id)

## Returns an iterator over streams that have outstanding data to read.
iterator readable*(conn: QuicheConnection): uint64 =
  var it = StreamIterator(internal: quiche_conn_readable(conn.internal))
  for id in it.ids():
    yield id

## Returns an iterator over streams that can be written to.
iterator writable*(conn: QuicheConnection): uint64 =
  var it = StreamIterator(internal: quiche_conn_writable(conn.internal))
  for id in it.ids():
    yield id

## Returns the maximum possible size of egress UDP payloads.
proc max_send_udp_payload_size*(conn: QuicheConnection): csize_t =
  quiche_conn_max_send_udp_payload_size(conn.internal)

## Returns the amount of time until the next timeout event, in nanoseconds.
proc timeout_as_nanos*(conn: QuicheConnection): uint64 =
  quiche_conn_timeout_as_nanos(conn.internal)

## Returns the amount of time until the next timeout event, in milliseconds.
proc timeout_as_millis*(conn: QuicheConnection): uint64 =
  quiche_conn_timeout_as_millis(conn.internal)

## Processes a timeout event.
proc on_timeout*(conn: QuicheConnection) =
  quiche_conn_on_timeout(conn.internal)

## Closes the connection with the given error and reason.
proc close*(conn: QuicheConnection, app: bool, err: uint64, reason: openArray[uint8]): QuicheResult =
  quiche_conn_close(conn.internal, app, err, reason[0].addr, csize_t(reason.len)).toQuicheResult()

## Returns a string uniquely representing the connection.
proc trace_id*(conn: QuicheConnection): string =
  var id_handle: ptr uint8
  var id_len: csize_t
  quiche_conn_trace_id(conn.internal, id_handle.addr, id_len.addr)
  copyToString(id_handle, id_len)

## Returns the source connection ID.
proc source_id*(conn: QuicheConnection): string =
  var id_handle: ptr uint8
  var id_len: csize_t
  quiche_conn_source_id(conn.internal, id_handle.addr, id_len.addr)
  copyToString(id_handle, id_len)

## Returns all active source connection IDs.
iterator source_ids*(conn: QuicheConnection): string =
  var it = ConnectionIdIterator(internal: quiche_conn_source_ids(conn.internal))
  for id in it.ids():
    yield id

## Returns the destination connection ID.
proc destination_id*(conn: QuicheConnection): string =
  var id_handle: ptr uint8
  var id_len: csize_t
  quiche_conn_destination_id(conn.internal, id_handle.addr, id_len.addr)
  copyToString(id_handle, id_len)

## Returns the negotiated ALPN protocol.
proc application_proto*(conn: QuicheConnection): seq[uint8] =
  var id_handle: ptr uint8
  var id_len: csize_t
  quiche_conn_destination_id(conn.internal, id_handle.addr, id_len.addr)
  copyToSeq(id_handle, id_len)

## Returns the peer's leaf certificate (if any) as a DER-encoded buffer.
proc peer_cert*(conn: QuicheConnection): seq[uint8] =
  var handle: ptr uint8
  var len: csize_t
  quiche_conn_peer_cert(conn.internal, handle.addr, len.addr)
  copyToSeq(handle, len)

## Returns the serialized cryptographic session for the connection.
proc session*(conn: QuicheConnection): seq[uint8] =
  var handle: ptr uint8
  var len: csize_t
  quiche_conn_session(conn.internal, handle.addr, len.addr)
  copyToSeq(handle, len)

## Returns true if the connection handshake is complete.
proc is_established*(conn: QuicheConnection): bool =
  quiche_conn_is_established(conn.internal)

## Returns true if the connection is resumed.
proc is_resumed*(conn: QuicheConnection): bool =
  quiche_conn_is_resumed(conn.internal)

## Returns true if the connection has a pending handshake that has progressed
## enough to send or receive early data.
proc is_in_early_data*(conn: QuicheConnection): bool =
  quiche_conn_is_in_early_data(conn.internal)

## Returns whether there is stream or DATAGRAM data available to read.
proc is_readable*(conn: QuicheConnection): bool =
  quiche_conn_is_readable(conn.internal)

## Returns true if the connection is draining.
proc is_draining*(conn: QuicheConnection): bool =
  quiche_conn_is_draining(conn.internal)

## Returns the number of bidirectional streams that can be created
## before the peer's stream count limit is reached.
proc streams_left_bidi*(conn: QuicheConnection): uint64 =
  quiche_conn_peer_streams_left_bidi(conn.internal)

## Returns the number of unidirectional streams that can be created
## before the peer's stream count limit is reached.
proc streams_left_uni*(conn: QuicheConnection): uint64 =
  quiche_conn_peer_streams_left_uni(conn.internal)

## Returns true if the connection is closed.
proc is_closed*(conn: QuicheConnection): bool =
  quiche_conn_is_closed(conn.internal)

## Returns Some(ConnErrorInfo) if a connection error was received.
proc peer_error*(conn: QuicheConnection): Option[ConnErrorInfo] =
  var is_app: bool
  var error_code: uint64
  var reason_handle: ptr uint8
  var reason_len: csize_t
  if quiche_conn_peer_error(conn.internal, is_app.addr, error_code.addr, reason_handle.addr, reason_len.addr):
    some(ConnErrorInfo(
      is_app: is_app, 
      error_code: error_code,
      reason: copyToString(reason_handle, reason_len)))
  else:
    none(ConnErrorInfo)

## Returns Some(ConnErrorInfo) if a connection error was queued or sent.
proc local_error*(conn: QuicheConnection): Option[ConnErrorInfo] =
  var is_app: bool
  var error_code: uint64
  var reason_handle: ptr uint8
  var reason_len: csize_t
  if quiche_conn_local_error(conn.internal, is_app.addr, error_code.addr, reason_handle.addr, reason_len.addr):
    some(ConnErrorInfo(
      is_app: is_app, 
      error_code: error_code,
      reason: copyToString(reason_handle, reason_len)))
  else:
    none(ConnErrorInfo)

## Collects and returns statistics about the connection.
proc stats*(conn: QuicheConnection): struct_quiche_stats =
  var s: struct_quiche_stats
  quiche_conn_stats(conn.internal, s.addr)
  s

## Returns the peer's transport parameters. Returns None if we have
## not yet processed the peer's transport parameters.
proc peer_transport_params*(conn: QuicheConnection): Option[struct_quiche_transport_params] =
  var params: struct_quiche_transport_params
  if quiche_conn_peer_transport_params(conn.internal, params.addr):
    some(params)
  else:
    none(struct_quiche_transport_params)


## Collects and returns statistics about the specified path for the connection.
##
## The `idx` argument represent the path's index (also see the `paths_count`
## field of `quiche_stats`).
proc path_stats*(conn: QuicheConnection, idx: csize_t): Result[struct_quiche_path_stats, QuicheError] =
  var stats: struct_quiche_path_stats
  var res = quiche_conn_path_stats(conn.internal, idx, stats.addr).toQuicheResult()
  res.map do () -> struct_quiche_path_stats: stats

## Returns whether or not this is a server-side connection.
proc is_server*(conn: QuicheConnection): bool =
  quiche_conn_is_server(conn.internal)

## Returns the maximum DATAGRAM payload that can be sent.
proc dgram_max_writable_len*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_max_writable_len(conn.internal).toSizeResult()

## Returns the length of the first stored DATAGRAM.
proc dgram_recv_front_len*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_recv_front_len(conn.internal).toSizeResult()

## Returns the number of items in the DATAGRAM receive queue.
proc dgram_recv_queue_len*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_recv_queue_len(conn.internal).toSizeResult()

## Returns the total size of all items in the DATAGRAM receive queue.
proc dgram_recv_queue_byte_size*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_recv_queue_byte_size(conn.internal).toSizeResult()

## Returns the number of items in the DATAGRAM send queue.
proc dgram_send_queue_len*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_send_queue_len(conn.internal).toSizeResult()

## Returns the total size of all items in the DATAGRAM send queue.
proc dgram_send_queue_byte_size*(conn: QuicheConnection): SizeResult =
  quiche_conn_dgram_send_queue_byte_size(conn.internal).toSizeResult()

## Reads the first received DATAGRAM.
proc dgram_recv*(conn: QuicheConnection, buf: openArray[uint8]): SizeResult =
  quiche_conn_dgram_recv(conn.internal, buf[0].addr, csize_t(buf.len)).toSizeResult()

## Sends data in a DATAGRAM frame.
proc dgram_send*(conn: QuicheConnection, buf: openArray[uint8]): SizeResult =
  quiche_conn_dgram_send(conn.internal, buf[0].addr, csize_t(buf.len)).toSizeResult()

type
  DgramPredicate* = proc (buf: ptr uint8, len: csize_t): bool {.cdecl.}

## Purges queued outgoing DATAGRAMs matching the predicate.
proc dgram_purge_outgoing*(conn: QuicheConnection, predicate: DgramPredicate) =
  quiche_conn_dgram_purge_outgoing(conn.internal, predicate)

## Returns whether or not the DATAGRAM send queue is full.
proc is_dgram_send_queue_full*(conn: QuicheConnection): bool =
  quiche_conn_is_dgram_send_queue_full(conn.internal)

## Returns whether or not the DATAGRAM recv queue is full.
proc is_dgram_recv_queue_full*(conn: QuicheConnection): bool =
  quiche_conn_is_dgram_recv_queue_full(conn.internal)

## Schedule an ack-eliciting packet on the active path.
proc send_ack_eliciting*(conn: QuicheConnection): SizeResult =
  quiche_conn_send_ack_eliciting(conn.internal).toSizeResult()

