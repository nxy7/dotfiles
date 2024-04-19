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

    # shell stuff
    ./wezterm
    ./zoxide

    # programming
    ./git
    ./work

    ./starship
    ./direnv
    ./broot
  ] ++ lib.optionals (fullSystem) [
    inputs.base16.homeManagerModule

    ./services.nix

    ./hyprland
    ./hyprland/theme.nix
    ./hyprland/ags

    ./obs-studio

    ./gamelaunchers
    ./browsers
    # ./davinci_resolve
    ./packages
  ];
}
