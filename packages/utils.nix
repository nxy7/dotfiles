{ pkgs, ... }:
with pkgs; [
  redis
  texlive.combined.scheme-full
  neofetch
  freshfetch
  tilt
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
