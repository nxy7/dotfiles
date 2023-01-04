username:
{ inputs, pkgs, fullSystem ? true, ... }:
let lib = pkgs.lib;
in {
  mainpc = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = { inherit inputs pkgs username fullSystem; };

    modules = [
      ({ config, ... }: { config.scheme = ../theme.yaml; })
      inputs.stylix.homeManagerModules.stylix
      inputs.base16.homeManagerModule

      # ../home-modules/hyprland.nix
      # ../home-modules/niri.nix
      # ../home-modules/waybar.nix

      ./stylix.nix
      ./homesettings.nix

      ./shells.nix
      ./browsers.nix
      ./zed.nix

      # programming
      ./wezterm.nix
      ./work.nix

    ] ++ lib.optionals (fullSystem) [

      ./services.nix

      ./obs-studio

      ./packages.nix
      ./programs.nix
    ];
  };
}
