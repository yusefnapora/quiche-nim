import ffi

type 
  QuicheConfig* = object
    internal: ptr struct_quiche_config

proc `=destroy`*(config: QuicheConfig) =
  if config.internal != nil:
    quiche_config_free(config.internal)

## Creates a config object with the given version.
proc newQuicheConfig*(version: int): QuicheConfig =
  var internal = quiche_config_new(uint32(version))
  QuicheConfig(internal: internal)

## Configures the given certificate chain.
proc load_cert_chain_from_pem_file*(config: QuicheConfig, path: string): int =
  quiche_config_load_cert_chain_from_pem_file(config.internal, cstring(path))

## Configures the given private key.
proc load_priv_key_from_pem_file*(config: QuicheConfig, path: string): int = 
  quiche_config_load_priv_key_from_pem_file(config.internal, cstring(path))

## Specifies a file where trusted CA certificates are stored for the purposes of certificate verification.
proc load_verify_locations_from_file*(config: QuicheConfig, path: string): int =
  quiche_config_load_verify_locations_from_file(config.internal, cstring(path))

## Specifies a directory where trusted CA certificates are stored for the purposes of certificate verification.
proc load_verify_locations_from_directory*(config: QuicheConfig, path: string): int =
  quiche_config_load_verify_locations_from_directory(config.internal, cstring(path))

## Configures whether to verify the peer's certificate.
proc verify_peer*(config: QuicheConfig, value: bool) =
  quiche_config_verify_peer(config.internal, value)

## Configures whether to send GREASE.
proc grease*(config: QuicheConfig, value: bool) =
  quiche_config_grease(config.internal, value)

## Configures whether to do path MTU discovery.
proc discover_pmtu*(config: QuicheConfig, value: bool) =
  quiche_config_discover_pmtu(config.internal, value)

## Enables logging of secrets.
proc log_keys*(config: QuicheConfig) =
  quiche_config_log_keys(config.internal)

## Enables sending or receiving early data.
proc enable_early_data*(config: QuicheConfig) =
  quiche_config_enable_early_data(config.internal)

## Configures the list of supported application protocols.
proc set_application_protos*(config: QuicheConfig, protos: openArray[char]): int =
  quiche_config_set_application_protos(
    config.internal, 
    cast[ptr uint8](protos.addr), 
    csize_t(protos.len))

## Sets the anti-amplification limit factor.
proc set_max_amplification_factor*(config: QuicheConfig, value: csize_t) =
  quiche_config_set_max_amplification_factor(config.internal, value)

## Sets the `max_idle_timeout` transport parameter, in milliseconds, default is no timeout.
proc set_max_idle_timeout*(config: QuicheConfig, value: uint64) =
  quiche_config_set_max_idle_timeout(config.internal, value)

## Sets the `max_udp_payload_size transport` parameter.
proc set_max_recv_udp_payload_size*(config: QuicheConfig, value: csize_t) =
  quiche_config_set_max_recv_udp_payload_size(config.internal, value)

## Sets the maximum outgoing UDP payload size.
proc set_max_send_udp_payload_size*(config: QuicheConfig, value: csize_t) =
  quiche_config_set_max_send_udp_payload_size(config.internal, value)

## Sets the `initial_max_data` transport parameter.
proc set_initial_max_data*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_data(config.internal, value)

## Sets the `initial_max_stream_data_bidi_local` transport parameter.
proc set_initial_max_stream_data_bidi_local*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_stream_data_bidi_local(config.internal, value)

## Sets the `initial_max_stream_data_bidi_remote` transport parameter.
proc set_initial_max_stream_data_bidi_remote*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_stream_data_bidi_remote(config.internal, value)

## Sets the `initial_max_stream_data_uni` transport parameter.
proc set_initial_max_stream_data_uni*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_stream_data_uni(config.internal, value)

## Sets the `initial_max_streams_bidi` transport parameter.
proc set_initial_max_streams_bidi*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_streams_bidi(config.internal, value)

## Sets the `initial_max_streams_uni` transport parameter.
proc set_initial_max_streams_uni*(config: QuicheConfig, value: uint64) =
  quiche_config_set_initial_max_streams_uni(config.internal, value)

## Sets the `ack_delay_exponent` transport parameter.
proc set_ack_delay_exponent*(config: QuicheConfig, value: uint64) =
  quiche_config_set_ack_delay_exponent(config.internal, value)

## Sets the `max_ack_delay` transport parameter.
proc set_max_ack_delay*(config: QuicheConfig, value: uint64) =
  quiche_config_set_max_ack_delay(config.internal, value)

## Sets the `disable_active_migration` transport parameter.
proc set_disable_active_migration*(config: QuicheConfig, value: bool) =
  quiche_config_set_disable_active_migration(config.internal, value)

## Sets the congestion control algorithm used by string.
proc set_cc_algorithm_name*(config: QuicheConfig, name: string): int =
  quiche_config_set_cc_algorithm_name(config.internal, cstring(name))

## Sets the initial cwnd for the connection in terms of packet count.
proc set_initial_congestion_window_packets*(config: QuicheConfig, packets: csize_t) =
  quiche_config_set_initial_congestion_window_packets(config.internal, packets)

## Sets the congestion control algorithm used.
proc set_cc_algorithm*(config: QuicheConfig, algo: enum_quiche_cc_algorithm) =
  quiche_config_set_cc_algorithm(config.internal, algo)

## Configures whether to use HyStart++.
proc enable_hystart*(config: QuicheConfig, value: bool) =
  quiche_config_enable_hystart(config.internal, value)

## Configures whether to enable pacing (enabled by default).
proc enable_pacing*(config: QuicheConfig, value: bool) =
  quiche_config_enable_pacing(config.internal, value)

## Configures max pacing rate to be used.
proc set_max_pacing_rate*(config: QuicheConfig, value: uint64) =
  quiche_config_set_max_pacing_rate(config.internal, value)

## Configures whether to enable receiving DATAGRAM frames.
proc enable_dgram*(config: QuicheConfig, enabled: bool, recv_queue_len: csize_t, send_queue_len: csize_t) =
  quiche_config_enable_dgram(config.internal, enabled, recv_queue_len, send_queue_len)

## Sets the maximum connection window.
proc set_max_connection_window*(config: QuicheConfig, value: uint64) =
  quiche_config_set_max_connection_window(config.internal, value)

## Sets the maximum stream window.
proc set_max_stream_window*(config: QuicheConfig, value: uint64) =
  quiche_config_set_max_stream_window(config.internal, value)

## Sets the limit of active connection IDs.
proc set_active_connection_id_limit*(config: QuicheConfig, value: uint64) =
  quiche_config_set_active_connection_id_limit(config.internal, value)

## Sets the initial stateless reset token. `value` must contain 16 bytes, otherwise the behaviour is undefined.
proc set_stateless_reset_token*(config: QuicheConfig, value: array[0..15, byte]) =
  quiche_config_set_stateless_reset_token(config.internal, cast[ptr uint8](value.addr))

## Sets whether the QUIC connection should avoid reusing DCIDs over different paths.
proc set_disable_dcid_reuse*(config: QuicheConfig, value: bool) =
  quiche_config_set_disable_dcid_reuse(config.internal, value)

## Configures the session ticket key material.
proc set_ticket_key*(config: QuicheConfig, ticket: openArray[char]): int =
  quiche_config_set_ticket_key(
    config.internal,
    cast[ptr uint8](ticket.addr),
    csize_t(ticket.len))


