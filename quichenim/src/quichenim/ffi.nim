import futhark

importc:
  path  "./quichenim/artifacts"
  sysPath "/nix/store/na9g3654cpwgsbivqcssqy225x3kafsn-libSystem-11.0.0/include"
  sysPath "/nix/store/k8mrxviw965lv59hqbln3297jwfffm2w-clang-wrapper-16.0.6/resource-root/include"
  "quiche.h"

{.passl: "./src/quichenim/artifacts/libquiche.a".}

proc version*(): string =
  var v = quiche_version()
  $v
