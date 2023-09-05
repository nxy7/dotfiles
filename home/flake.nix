{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    helix-master.url = "github:helix-editor/helix";
    tailwindcss-lsp.url = "github:nxy7/tailwindcss-intellisense";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, flake-parts, home-manager, nixpkgs, ... }@inputs:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = import ./overlays.nix { inherit inputs system; };
      };
      system = "x86_64-linux";
      currentUser = builtins.getEnv "USER";
      pcConfiguration = name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            username = name;
            inherit inputs;
          };
          modules = [ ./. ];
        };
    in {
      uname = currentUser;
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        # homeConfigurations.kraja = pcConfiguration "kraja";
        # homeConfigurations.nxyt = pcConfiguration "nxyt";
        # homeConfigurations.nxy7 = pcConfiguration "nxy7";
        homeConfigurations.${currentUser} = pcConfiguration currentUser;
        # homeConfigurations.nxyt = pcConfiguration "nxyt";
      };
    };
}
