{ pkgs, ... }:
with pkgs; [
  nixfmt
  zoxide
  bat
  cargo-espflash
  bun
  gitoxide
  sqlc
  htop
  sccache
  nodePackages_latest.ts-node
  gopls
  rust-analyzer
  python39
  qmk
  google-cloud-sdk-gce
  ripgrep
  # rust support
  rustup
  # golang support
  go
  # javascript packages
  nodejs
  deno
  yarn
  nodePackages.pnpm

  # all stuff necesarry for helix lsp
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.prettier
  # other languages
  julia
  php

  # dev setup
  gcc
  # binutils-unwrapped_2_38
  lazygit
  tmux
  gh
]
