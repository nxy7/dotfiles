{ pkgs ? import <nixpkgs>, home-manager, inputs }: rec {
  byName = name:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        username = name;
        inherit inputs;
      };
      modules = [ ./. ];
    };
  currentUser = builtins.getEnv "USER";
  currentUserConfiguration = byName currentUser;
}
