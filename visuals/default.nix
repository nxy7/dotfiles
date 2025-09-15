{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./gnome.nix
    # ./hyprland.nix
    # ./gaming.nix
    ./fonts.nix
    ./audio.nix
  ];
  options = {
    myModule.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "tbd";
    };
  };

  config = lib.mkIf config.myModule.enable {

  };
}
