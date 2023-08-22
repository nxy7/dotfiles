{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-master.url = "github:helix-editor/helix";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, utils, home-manager, system-manager, nixpkgs, rust-overlay
    , ... }@inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = (_: true);
          overlays = [
            (import rust-overlay)
            (import ./overlays.nix { inherit inputs system; })
            # (final: prev: {
            #   helix = inputs.helix-master.packages.${system}.default;
            #   pomodorust = inputs.pomodorust.packages.${system}.default;
            # })
          ];
        };
        pcConfiguration = name:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = { username = name; };
            modules = [ ./home.nix ];

          };

      in {
        packages = {
          default = home-manager.defaultPackage.${system};
          # homeConfigurations.root = pcConfiguration "root";
          homeConfigurations.kraja = pcConfiguration "kraja";
          homeConfigurations.nxyt = pcConfiguration "nxyt";
          homeConfigurations.nxy7 = pcConfiguration "nxy7";
        };

        systemConfigs.default = self.lib.makeSystemConfig {
          system = utils.lib.system.x86_64-linux;
          modules = [ ./modules ];
        };

      });
}
