import ffi
import errors
export errors 

type
  QuicheConnection* = object
    internal: ptr struct_quiche_conn

proc `=destroy`*(conn: QuicheConnection) =
  if conn.internal != nil:
    quiche_conn_free(conn.internal)

proc toQuicheConnection(raw: ptr struct_quiche_conn): QuicheConnection =
  QuicheConnection(internal: raw)

