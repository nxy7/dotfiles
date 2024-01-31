{ home-manager, inputs, pkgs, stablepkgs, ... }:
let username = builtins.getEnv "USER";

in home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = { inherit inputs pkgs stablepkgs username; };

  modules = [
    # merge stylix base16 with some extra colors
    inputs.base16.homeManagerModule
    ({ config, ... }: { config.scheme = ../theme.yaml; })

    inputs.stylix.homeManagerModules.stylix
    ./stylix
    ./services.nix

    # base
    ./homesettings

    # display
    inputs.ags.homeManagerModules.default
    ./hyprland
    ./hyprland/theme.nix
    ./hyprland/ags

    ./obs-studio
    # editors
    ./helix
    # ./neovim

    # shells
    ./nushell
    # ./fish
    # ./zsh
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
    ./packages
  ];
}
