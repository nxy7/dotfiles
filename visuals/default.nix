{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./fonts.nix
    ./audio.nix
  ];
}
