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
        ./modules/helix
        ./modules/nodejs
        ./modules/utilities
        # ./neovim
        # ./wezterm
        # ./others 
      ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
