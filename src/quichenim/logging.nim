import std/options
import ffi
import errors

type
  DebugLogger = object
    log: proc (line: string): void

var globalLogger: Option[DebugLogger] = none(DebugLogger)

proc debugLogHook(line: cstring, arg: pointer) {. cdecl .} =
  if globalLogger.isSome:
    globalLogger.get().log($line)

proc quiche_debug_log*(logFn: proc (line: string): void): QuicheResult =
  globalLogger = some(DebugLogger(log: logFn))
  quiche_enable_debug_logging(debugLogHook, nil).toQuicheResult()
