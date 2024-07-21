# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import std/sequtils
import quichenim/ffi
import quichenim/config

when isMainModule:
  echo "quiche version: ", version()
  var cfg = newQuicheConfig(QUICHE_PROTOCOL_VERSION)
  echo "created a config object without blowing up", cfg
  var res = cfg.set_application_protos("http/0.9")
  echo "set app protos. result: ", res

  cfg.set_cc_algorithm(enum_quiche_cc_algorithm.QUICHE_CC_RENO)
  echo "set cc algo"