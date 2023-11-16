{ pkgs, home-manager, inputs }: rec {
  byName = name:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        username = name;
        inherit inputs;
      };
      modules = [
        # base
        ./modules/homesettings

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

        # others
        ./modules/starship
        ./modules/direnv
        ./modules/oh-my-posh
        ./modules/broot
        ./modules/utilities
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
