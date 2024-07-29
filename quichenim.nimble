# Package

version       = "0.1.0"
author        = "Yusef Napora"
description   = "PoC of using quiche for QUIC support in Nim"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["quichenim"]


# Dependencies

requires "nim >= 2.0.4"
requires "futhark >= 0.13.2"
requires "results >= 0.4.0"

# Paths to quiche artifacts
let 
  artifactsDir = "./" & srcDir & "/quichenim/artifacts"
  quicheDir = "./" & srcDir & "/../vendor/quiche"
  header = quicheDir & "/quiche/include/quiche.h"
var 
  staticLib = "libquiche.a"
  dynamicLib = "libquiche.so"
  profile = "dev"
  target = "debug"

when(defined(release)):
  profile = "release"
  target = "release"
when(defined(macosx)):
  dynamicLib = "libquiche.dylib"
when(defined(windows)):
  staticLib = "libquiche.lib"
  dynamicLib = "libquiche.dll"

let
  targetDir = quicheDir & "/target/" & target
  staticLibSrcPath = targetDir & "/" & staticLib
  staticLibDestPath = artifactsDir & "/" & staticLib
  dynamicLibSrcPath = targetDir & "/" & dynamicLib
  dynamicLibDestPath = artifactsDir & "/" & dynamicLib
  passLStatic = "quichenim.PassL=" & staticLibDestPath

# echo "linker flags: " & passLStatic
# switch("define", passLStatic)

# Tasks
task quicheBuild, "Builds quiche for the current platform":
  var cargo = findExe("cargo")
  if cargo == "":
    # todo: add option to fetch precompiled binaries for popular platforms
    raise newException(Exception, "Building quiche from source requires a rust toolchain")
  cd(quicheDir)
  exec(cargo & " build --features ffi,boringssl-boring-crate --profile " & profile)
  cd("../..")

task copyArtifacts, "Copies compiled quiche artifacts to nim source tree":
  # copy build output to src/quichenim/artifacts
  if not dirExists(artifactsDir):
    mkDir(artifactsDir)

  cpFile(header, artifactsDir & "/quiche.h")
  cpFile(targetDir & "/" & staticLib, artifactsDir & "/" & staticLib)
  cpFile(targetDir & "/" & dynamicLib, artifactsDir & "/" & dynamicLib)

after quicheBuild:
  copyArtifactsTask()

before build:
  quicheBuildTask()
  copyArtifactsTask()