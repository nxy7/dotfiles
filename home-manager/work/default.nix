{ pkgs, ... }:
let
  programmingPackages = with pkgs; [
    bun

    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    nodePackages_latest.bash-language-server
  ];
  otherPackages = with pkgs; [ jetbrains.datagrip nest-cli slack insomnia ];
in { home.packages = programmingPackages ++ otherPackages; }
