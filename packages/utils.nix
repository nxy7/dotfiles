{ pkgs, ... }:
with pkgs; [
  texlive.combined.scheme-full
  cachix
  freshfetch
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
