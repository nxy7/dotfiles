# Languages are empty as I'm configuring them per-project and not globally now
{ pkgs, ... }:
with pkgs; [
  nodePackages.yaml-language-server
  taplo
]
