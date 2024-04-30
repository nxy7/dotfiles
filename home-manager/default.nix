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

    # shells
    ./homesettings
    ./helix
    ./nushell
    ./fish
    ./bash
    ./elvish

    # shell stuff
    ./wezterm
    ./zoxide

    # programming
    ./git
    ./work

  ] ++ lib.optionals (fullSystem) [
    inputs.base16.homeManagerModule

    ./services.nix

    ./obs-studio

    ./packages
    ./programs
  ];
}
