{ pkgs, ... }:
let
  programmingPackages = with pkgs; [
    bun

    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    dotnet-sdk_8

  ];
  otherPackages = with pkgs; [
    jetbrains.datagrip
    azuredatastudio
    dbeaver-bin
    nest-cli
    slack
    insomnia
  ];
in { home.packages = programmingPackages ++ otherPackages; }
