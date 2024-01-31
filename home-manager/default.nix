{ home-manager, inputs, pkgs, stablepkgs, ... }:
let username = builtins.getEnv "USER";

in home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = { inherit inputs pkgs stablepkgs username; };

  modules = [
    inputs.stylix.homeManagerModules.stylix

    # base
    ./homesettings
    ./stylix

    # merge stylix base16 with some extra colors
    # ({ config, ... }: rec {
    #   config.colorPalette = config.lib.stylix.colors // {
    #     red = "cd3263";
    #     green = "6bcd32";
    #     yellow = "c8cd32";
    #     blue = "32a4cd";
    #     magenta = "cd32cb";
    #     teal = "32cdac";
    #     orange = "cd9432";
    #   };
    # })

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
    ./packages
  ];
}
