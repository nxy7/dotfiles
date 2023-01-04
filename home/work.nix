{ pkgs, stablePkgs, inputs, ... }:
let
  rocPkgs = inputs.roc.packages."x86_64-linux";

  programmingPackages = with pkgs; [
    bun
    postgresql_17
    azure-storage-azcopy
    # python3
    # jupyter-all

    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    dotnetPackages.Nuget
    dotnet-sdk_9
    dotnet-ef

    terraform
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    kubectl
    kubelogin
    redis
    pkgs.nodePackages.cdktf-cli

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
