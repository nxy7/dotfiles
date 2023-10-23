{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    unstablePkgs.url = "nixpkgs/nixos-unstable";
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
      homeConfiguration = import ./home/homeConfiguration.nix {
        inherit pkgs home-manager inputs;
      };
      currentUser = builtins.getEnv "USER";
    in {
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.${currentUser} =
          homeConfiguration.byName currentUser;
      };
    };
}
