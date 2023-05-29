{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-master.url = "github:pinelang/helix-tree-explorer/tree_explore";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager.url = "github:nix-community/home-manager";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    utils.url = "github:numtide/flake-utils";
    nci.url = "github:yusdacra/nix-cargo-integration";
  };

  outputs = { self, utils, home-manager, system-manager, nixpkgs, helix-master
    , nci, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
      let
        helixOverlay = import overlays/helix.nix helix-master system;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = (_: true);
          overlays = [ helixOverlay (import rust-overlay) ];
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
