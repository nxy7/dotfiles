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
        ./modules/homesettings

        # display
        ./modules/hyprland

        # editors
        ./modules/helix
        ./modules/neovim

        # shells
        ./modules/nushell
        ./modules/fish
        ./modules/zsh
        ./modules/bash

        # shell stuff
        ./modules/wezterm
        ./modules/zellij
        ./modules/zoxide

        # programming
        ./modules/git
        ./modules/nodejs
        ./modules/rust
        ./modules/golang

        # others
        ./modules/browsers
        # ./modules/davinci_resolve
        ./modules/starship
        ./modules/direnv
        # ./modules/oh-my-posh
        ./modules/broot
        ./modules/utilities
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
