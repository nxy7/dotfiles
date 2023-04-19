{ pkgs, ... }:
with pkgs; [
  nodePackages_latest.ts-node
  nodejs
  deno
  yarn
  nodePackages.pnpm
]
