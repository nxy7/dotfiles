{ pkgs, ... }:
with pkgs; [
  redis
  sqlx-cli
  pkg-config
  openssl
  kubectl
  imagemagick
  pngcrush
  zoxide
  bat
  cargo-espflash
  bun
  gitoxide
  sqlc
  htop
  sccache
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
  nodePackages_latest.ts-node
  nodejs
  deno
  yarn
  nodePackages.pnpm

  # Helix Stuff
  nixfmt
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
  gh
]
