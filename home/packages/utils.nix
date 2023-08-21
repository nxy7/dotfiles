{ pkgs, ... }:
with pkgs; [
  buildah-unwrapped
  pomodoro
  nix-prefetch-github
  exa
  pgweb
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
