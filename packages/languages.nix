{ pkgs, ... }:
with pkgs; [
  gcc

  go
  gopls
  julia
  php
  nodePackages_latest.svelte-language-server

  python39
  python39Packages.pip

  rust-bin.stable.latest.default
  cargo-nextest
]
