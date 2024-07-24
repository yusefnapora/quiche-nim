const SysPathSystem {. strdefine: "quichenim.SysPathSystem" .}: string = ""
const SysPathClang  {. strdefine: "quichenim.SysPathClang" .}: string = ""
const PassL {. strdefine: "quichenim.PassL" .}: string = ""

when defined(useFuthark) or defined(useFutharkForQuichenim):
  import futhark, os

  importc:
    outputPath currentSourcePath.parentDir / "futhark_generated.nim"
    path  "./quichenim/artifacts"
    sysPath SysPathSystem
    sysPath SysPathClang
    "quiche.h"
else:
  include "futhark_generated.nim"

{. passl: PassL .}

