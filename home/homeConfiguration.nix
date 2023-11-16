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
        ./modules/utilities
        ./modules/direnv
        # ./neovim
        # ./wezterm
        # ./others 
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
