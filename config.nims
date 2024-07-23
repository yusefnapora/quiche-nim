# begin Nimble config (version 2)
import os, strutils

var clangPath = findExe("clang")
if "/nix/store" in clangPath:
  var packageDir = clangPath.replace("/bin/clang", "")
  var cflagsFilePath = packageDir & "/nix-support/libc-cflags"
  var cflagsContent = readFile(cflagsFilePath)
  var sysIncludeDir = cflagsContent.split(" ")[1]
  var clangIncludeDir = packageDir & "/resource-root/include"

  echo "sys include path: " & sysIncludeDir
  echo "clang include path: " & clangIncludeDir
  switch("d:quichenim.SysPathSystem", sysIncludeDir)
  switch("d:quichenim.SysPathClang", clangIncludeDir)

--noNimblePath
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"

switch("define", "foo=bar")

# end Nimble config
