{ pkgs, ... }:
with pkgs; [
  gcc
  go
  gopls
  julia
  php

  python39
  python39Packages.pip

  rust-analyzer
  rustup
  cargo-nextest
]
