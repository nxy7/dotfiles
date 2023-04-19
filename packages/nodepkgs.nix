{ pkgs, ... }:
with pkgs; [
  deno
  nodejs
  nodePackages_latest.ts-node
  nodePackages.pnpm
  yarn
]
