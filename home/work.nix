{ pkgs, ... }:
let

  programmingPackages = with pkgs; [
    # expert
    pv
    azure-storage-azcopy

    jq
    nodejs
    deno
    yarn

    nodePackages_latest.ts-node
    nodePackages.pnpm

    dotnetCorePackages.dotnet_9.sdk
    dotnetCorePackages.dotnet_9.runtime
    dotnetCorePackages.dotnet_9.aspnetcore

    pkgs.nodePackages.cdktf-cli

  ];
  devopsPackages = with pkgs; [
    freerdp
    rdesktop
    terraform
    kubectl
    kubelogin
    wireshark
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
  ];
  otherPackages =
    with pkgs;
    with jetbrains;
    [
      jetbrains-toolbox
      livebook

      datagrip
      rider

      idea-ultimate
      jprofiler
      webstorm
      claude-code

      slack
      redis
      postgresql_17
    ];
in
{
  home.packages = programmingPackages ++ otherPackages ++ devopsPackages;
}
