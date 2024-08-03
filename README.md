# quiche-nim

> A bit of hacking around on wrapping Cloudflare's quiche QUIC stack with nim.

**Not yet functional - do not use!**

## About

This is me trying to learn nim, really. I got interested in it recently, specifically in the context of networking, as in [libp2p](https://libp2p.io).

There's a whole thing already underway to get QUIC working in nim called [nim-quic](https://github.com/vacp2p/nim-quic), which is much more mature than this thing is likely to ever get. So if you're looking for QUIC in nim and found this repo, you probably want nim-quic instead.

This repo is me getting my hands dirty with nim in a real world context that I know well enough to feel fairly at home in, but not so well that it's boring.

## Goals

Since this is about me personally learning nim, what am I actually trying to accomplish here?

Concretely, my first target is porting the example client from rust / c to nim, using the wrapper in [src/quichenim](./src/quichenim).

On a more meta level, arriving at that goal requires a few things:

- [x] learn nim and nimble well enough to get started
- [x] play with quiche a bit and learn about the C FFI interface
- [x] figure out how to wrap a C API in nim
  - I decided on [futhark](https://github.com/PMunch/futhark) on the basis that it was the first thing I tried that worked.
- [-] wrap the generated API to make it all nice like
  - still figuring out "idiomatic" nim, so this needs work still
  - recently found a good [style guide](https://status-im.github.io/nim-style-guide/00_introduction.html), will dig in soon
- [-] dig into nim's [`asyncdispatch`](https://nim-lang.org/docs/asyncdispatch.html) and [`asycnet`](https://nim-lang.org/docs/asyncnet.html) modules
  - currently using asyncdispatch directly since its APIs expose `ptr SockAddr` and friends that quiche wants
  - also it looks like it will give me more control over the event loop if needed

## Setup & Build

So far, I've only tested this with [nix](https://nix.dev/) using the `flake.nix` in this repo. It should also work with other package managers, provided you have a recent rust toolchain, `clang`, and nim and friends.

If you are using nix, you can `nix develop` in this repo, or use direnv with `echo 'use flake' > .envrc` followed by `direnv allow`.

Once that's all good, you should be able to run `nimble build --debug` which will also build `quiche` on the first run and copy the library and header files to where the ffi code expects them.

By default, the build statically links to `libquiche.a`, which kind of sucks cause the hello world binary is 15MB. If you set `-d:quichenim.UseDynamicLinking` it will link dynamically instead, but I had to mess about with symlinks and `DYLD_FALLBACK_LIBRARY_PATH` to get it to run and I haven't bothered automating that yet.

The `quichenim` binary that gets built by `nimble build` is a work-in-progress port of the client in [vendor/quiche/quiche/examples](./vendor/quiche/quiche/examples).

With the example server running on, e.g. `127.0.0.1:4567`, you can run the client with:

```
./quichenim http://127.0.0.1:4567/
```

It should print some logs at you and eventually print the response from the example server (`byez`)

## Up next

- clean up and refactor things
- add tests & wire up valgrind to make sure we're not leaking stuff
- think more about high-level API design
