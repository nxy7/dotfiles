{ pkgs, home-manager, inputs }: rec {
  byName = name:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        username = name;
        inherit inputs;
      };
      modules = [
        ./.
        ./modules/homesettings
        ./modules/helix
        ./modules/nodejs
        ./modules/direnv
        ./modules/neovim
        ./modules/wezterm
        ./modules/zellij
        ./modules/zoxide
        ./modules/utilities
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
