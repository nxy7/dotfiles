{ pkgs, ... }:
with pkgs; [
  buildah-unwrapped
  nix-prefetch-github
  exa
  du-dust
  hyperfine
  htop

  pueue
  keepassxc
  ventoy
  cachix
  freshfetch
  rnix-lsp
  nil
  hugo
  k9s
  kustomize
  kube3d
  kubectl
  colorls
  bat
  ripgrep
]
