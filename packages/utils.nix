{ pkgs, ... }:
with pkgs; [
  redis
  postgresql_15
  devspace
  taplo
  bat
  bun
  cargo-espflash
  gitoxide
  google-cloud-sdk-gce
  htop
  imagemagick
  openssl
  pkg-config
  pngcrush
  qmk
  redis
  ripgrep
  sccache
  sqlc
  sqlx-cli
  zoxide
]
