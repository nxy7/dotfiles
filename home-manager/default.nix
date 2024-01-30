{ home-manager, inputs, pkgs, stablepkgs, ... }:
let
  username = builtins.getEnv "USER";
  theme = inputs.nix-colors.colorSchemes.nord;
  # theme.palette = theme.palette // {
  #   palette.colors.red = "ffffff";
  #   # palette.colors.green = "ffffff";
  #   # palette.colors.yellow = "ffffff";
  #   # palette.colors.blue = "ffffff";
  #   # palette.colors.magenta = "ffffff";
  #   # palette.colors.teal = "ffffff";
  #   # palette.colors.orange = "ffffff";
  # };

in home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = { inherit inputs pkgs stablepkgs username theme; };

  modules = [
    # inputs.anyrun.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    inputs.stylix.homeManagerModules.stylix
    {
      config.colorScheme = theme;
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
    ./packages
  ];
}
