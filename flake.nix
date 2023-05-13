{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-master.url = "github:pinelang/helix-tree-explorer/tree_explore";
    home-manager.url = "github:nix-community/home-manager";
    utils.url = "github:numtide/flake-utils";
    nci.url = "github:yusdacra/nix-cargo-integration";
  };

  outputs = { self, utils, home-manager, nixpkgs, helix-master, nci }:
    utils.lib.eachDefaultSystem (system:
      let
        helixOverlay = import overlays/helix.nix helix-master system;
        # poshOverlay = final: prev: {

        # };
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = (_: true);
          overlays = [ helixOverlay ];
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
          homeConfigurations.kraja = pcConfiguration "kraja";
          homeConfigurations.nxyt = pcConfiguration "nxyt";
          homeConfigurations.nxy7 = pcConfiguration "nxy7";
        };
      });
}
