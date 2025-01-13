{ pkgs, stablePkgs, inputs, ... }:
let
  rocPkgs = inputs.roc.packages."x86_64-linux";

  programmingPackages = with pkgs; [
    bun

    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    dotnet-sdk_8

    cargo
    rustc
    # omnisharp-roslyn

    rocPkgs.full

  ];
  otherPackages = with pkgs; [
    jetbrains.datagrip
    # azuredatastudio
    dbeaver-bin
    nest-cli
    slack
    insomnia
  ];
in { home.packages = programmingPackages ++ otherPackages; }
