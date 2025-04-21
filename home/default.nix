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

      ./stylix.nix
      ./homesettings.nix

      ./shells.nix
      ./zed.nix

      # programming
      ./work.nix
    ] ++ lib.optionals (fullSystem) [

      ./services.nix

      ./obs-studio

      ./packages.nix
      ./programs.nix
    ];
  };
}
