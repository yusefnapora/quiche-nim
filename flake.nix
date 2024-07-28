{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

 outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
    let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        inherit (pkgs) lib;
        inherit (pkgs.stdenv) isLinux isDarwin;

        rust-toolchain = pkgs.rust-bin.stable.latest.default;

        packages-common = with pkgs; [
          rust-toolchain
          pkg-config
          cmake
          gnumake
          just
          nim
          nimble
          clang
          libclang.dev

          # for building C examples:
          libev
          uthash
        ];

        packages-linux = packages-common;

        packages-darwin = packages-common ++ (with pkgs; [
          libiconv
          openssl # needed for `nimble install` to fetch nim packages
          darwin.apple_sdk.frameworks.Security
          darwin.apple_sdk.frameworks.CoreServices
          darwin.apple_sdk.frameworks.CoreFoundation
          darwin.apple_sdk.frameworks.Foundation
          darwin.apple_sdk.frameworks.AppKit
          darwin.apple_sdk.frameworks.WebKit
          darwin.apple_sdk.frameworks.Cocoa
        ]);

        packages = if isLinux then packages-linux else packages-darwin;

        # prevent warning about malloc_nano on macos:
        # https://stackoverflow.com/a/70209891
        shellHook = lib.optionalString isDarwin ''
          export MallocNanoZone=0
        '';
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = packages;
          inherit shellHook;
        };
      });
}
