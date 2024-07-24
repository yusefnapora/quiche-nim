# begin Nimble config (version 2)
import os, strutils

var clangPath = findExe("clang")
if "/nix/store" in clangPath:
  let 
    packageDir = clangPath.replace("/bin/clang", "")
    cflagsFilePath = packageDir & "/nix-support/libc-cflags"
    cflagsContent = readFile(cflagsFilePath)
    sysIncludeDir = cflagsContent.split(" ")[1]
    clangIncludeDir = packageDir & "/resource-root/include"

  echo "sys include path: " & sysIncludeDir
  echo "clang include path: " & clangIncludeDir
  switch("define", "quichenim.SysPathSystem=" & sysIncludeDir)
  switch("define", "quichenim.SysPathClang=" & clangIncludeDir)

--noNimblePath
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"

var staticLib = "libquiche.a"
when(defined(windows)):
  staticLib = "libquiche.lib"

when(defined(quichenim.UseDynamicLinking)):
  switch("define", "quichenim.PassL=-L./src/quichenim/artifacts -lquiche")
else: 
  switch("define", "quichenim.PassL=./src/quichenim/artifacts/" & staticLib)

# end Nimble config
