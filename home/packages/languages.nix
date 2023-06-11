{ pkgs, ... }:
with pkgs;
[
  # go
  # gopls
  # julia
  # php

  # python39
  # python39Packages.pip

  # (rust-bin.stable.latest.default.override {
  #   extensions = [ "cargo" "rust-analysis" "rust-src" "rust-std" "rustc" ];
  # })
  # cargo-nextest
]
