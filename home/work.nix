{ pkgs, ... }:
let

  programmingPackages = with pkgs; [
    inotify-tools
    git-crypt
    gitleaks
    bison
    flex
    fontforge
    makeWrapper
    pkg-config
    gnumake
    gcc
    libiconv
    autoconf
    automake
    libtool

    elixir
    # expert
    # aider-chat-full
    minicom
    screen
    esptool
    openssl
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
