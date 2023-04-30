{ pkgs, ... }:
with pkgs; [
  redis
  k3s
  kompose
  taplo
  bat
  bun
  cargo-espflash
  gitoxide
  google-cloud-sdk-gce
  htop
  imagemagick
  kubectl
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
