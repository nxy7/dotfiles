username:
{ inputs, pkgs, fullSystem ? true, ... }:
let lib = pkgs.lib;
in inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = { inherit inputs pkgs username fullSystem; };

  modules = [
    ({ config, ... }: { config.scheme = ../theme.yaml; })
    inputs.stylix.homeManagerModules.stylix
    ./stylix
    ./homesettings

    ./shells
    ./browsers

    # programming
    ./work
  ] ++ lib.optionals (fullSystem) [
    inputs.base16.homeManagerModule

    ./services.nix

    ./obs-studio

    ./packages
    ./programs
  ];
}
