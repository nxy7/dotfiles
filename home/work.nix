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
    nodejs
    yarn

    nodePackages.pnpm

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
      livebook
      datagrip
      claude-code

      slack
      redis
      postgresql_17
    ];
in
{
  home.packages = programmingPackages ++ otherPackages ++ devopsPackages;
}
