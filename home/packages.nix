{
  inputs,
  pkgs,
  lib,
  isLinux ? pkgs.stdenv.isLinux,
  isDarwin ? pkgs.stdenv.isDarwin,
  ...
}:
let
  # Packages available on both platforms
  commonPackages = with pkgs; [
    brave
    bombardier
    brotli
    caddy
    just
    obsidian
    discord
    vscode
    lnav
    htop
    btop
    tokei
  ];

  # Linux-only packages
  linuxPackages = with pkgs; [
    gimp
    nautilus
    figma-linux
    kooha
  ];
in
{
  home.packages = commonPackages ++ lib.optionals isLinux linuxPackages;
}
