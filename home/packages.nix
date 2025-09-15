{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kustomize
    kube3d
    kubectl
    grim
    slurp

    ungoogled-chromium
    brave

    jupyter
    bombardier
    brotli
    imagemagick
    caddy

    gnome-network-displays
    just
    figma-linux

    kooha

    diffutils

    unrar
    obsidian

    discord

    vscode
    lnav

    gimp3
    htop
    btop

    keepassxc

    tokei
  ];
}
