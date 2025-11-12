{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kubectl

    # ungoogled-chromium
    brave

    bombardier
    brotli
    caddy

    nautilus
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
