{ home-manager, inputs, pkgs, stablepkgs, ... }:
let
  username = builtins.getEnv "USER";
  theme = "test";

in home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = { inherit inputs pkgs stablepkgs username theme; };

  modules = [
    # inputs.anyrun.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    {
      config.colorScheme = inputs.nix-colors.colorSchemes.dracula;
    }

    # base
    ./homesettings

    # display
    ./hyprland
    ./hyprland/theme.nix
    # ./hyprland/eww
    ./hyprland/ags

    # editors
    ./helix
    ./neovim

    # shells
    ./nushell
    ./fish
    ./zsh
    ./bash

    # shell stuff
    ./wezterm
    ./zellij
    ./zoxide

    # programming
    ./git
    ./nodejs
    ./rust
    ./golang

    ./gamelaunchers

    # others
    ./browsers
    # ./davinci_resolve
    ./starship
    ./direnv
    # ./oh-my-posh
    ./broot
    ./utilities
  ];
}
