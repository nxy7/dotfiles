{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    helix-master.url = "github:helix-editor/helix";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

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
      pcConfiguration = name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { username = name; };
          modules = [ ./. ];

        };
    in {
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.kraja = pcConfiguration "kraja";
        homeConfigurations.nxyt = pcConfiguration "nxyt";
        homeConfigurations.nxy7 = pcConfiguration "nxy7";
      };
    };
}
