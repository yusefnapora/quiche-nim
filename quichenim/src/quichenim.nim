# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import quichenim/ffi
import quichenim/config

when isMainModule:
  echo "quiche version: ", version()
  var cfg = newQuicheConfig(QUICHE_PROTOCOL_VERSION)
  echo "created a config object without blowing up", cfg
  cfg.set_application_protos("http/0.9")
    .expect("unable to set application protocols")

  cfg.set_cc_algorithm(QuicheCCAlgorithm.Reno)

