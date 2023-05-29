{ pkgs, ... }:
with pkgs; [
  texlive.combined.scheme-full
  keepassxc
  cachix
  freshfetch
  rnix-lsp
  nil
  hugo
  telepresence2
  k9s
  kustomize
  kube3d
  kubectl
  colorls
  bat
  ripgrep
]
