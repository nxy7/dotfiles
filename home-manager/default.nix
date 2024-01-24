{ home-manager, inputs, pkgs, unstablepkgs, ... }: rec {
  byName = name:
    home-manager.lib.homeManagerConfiguration {
      pkgs = unstablepkgs;

      extraSpecialArgs = {
        username = name;
        inherit inputs;
        pkgs = unstablepkgs;
        legacypkgs = pkgs;
      };
      modules = [
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

        # others
        ./browsers
        # ./davinci_resolve
        ./starship
        ./direnv
        # ./oh-my-posh
        ./broot
        ./utilities
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
