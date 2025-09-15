{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    # inputs.dankMaterialShell.nixosModules.greeter

    ./gnome.nix
    # ./cosmic.nix
    # ./niri.nix
    ./fonts.nix
    ./audio.nix
  ];
}
