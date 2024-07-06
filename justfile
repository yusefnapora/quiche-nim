
# todo: add flags for debug vs release mode, etc
quiche:
  cd vendor/quiche && cargo build --features ffi,boringssl-boring-crate
  cp vendor/quiche/target/debug/*.{a,dylib} quichenim/src/quiche/artifacts/
  cp vendor/quiche/quiche/include/*.h quichenim/src/quiche/artifacts/


