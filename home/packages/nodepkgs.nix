{ pkgs, ... }:
with pkgs; [
  nodejs
  nodePackages_latest.ts-node
  nodePackages.pnpm
  yarn
]
