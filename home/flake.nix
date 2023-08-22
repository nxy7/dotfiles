{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    helix-master.url = "github:helix-editor/helix";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # flake-utils.follows = "utils";
      };
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    # utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-parts, home-manager, nixpkgs, ... }@inputs:
    # flake-parts.lib.mkFlake { inherit inputs; } {
    #   systems = [ "x86_64-linux" ];

    #   flake = 
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = import ./overlays.nix { inherit inputs system; };
      };
      system = "x86_64-linux";
      pcConfiguration = name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { username = name; };
          modules = [ ../home ];

        };
    in {
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.kraja = pcConfiguration "kraja";
        homeConfigurations.nxyt = pcConfiguration "nxyt";
        homeConfigurations.nxy7 = pcConfiguration "nxy7";
      };
    };

  # perSystem = { config, system, ... }:
  #   let
  #   in {

  #   };
  # };
}
