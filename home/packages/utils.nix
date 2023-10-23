{ pkgs, ... }:
with pkgs; [
  x2goclient
  lnav
  insomnia
  redis

  gnumake
  ginkgo
  buildah-unwrapped
  pomodorust
  fzf
  gh

  cilium-cli

  cmake
  llvmPackages_latest.llvm
  rocmPackages.llvm.clang

  nix-prefetch-github
  pgweb
  du-dust
  hyperfine
  htop
  gitui
  # porsmo

  pueue
  keepassxc
  ventoy
  cachix
  freshfetch

  hugo
  k9s
  kustomize
  kube3d
  kubectl
  colorls
  bat
  ripgrep
]
