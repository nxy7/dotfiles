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
      system = "x86_64-linux";
      currentUser = builtins.getEnv "USER";

      # nixpkgs
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = import ./overlays.nix { inherit inputs system; };
      };
      unstablepkgs = import inputs.unstablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      # other utilities
      homeConfiguration = import ./home/homeConfiguration.nix {
        pkgs = unstablepkgs;
        inherit home-manager inputs;
      };
    in {
      # run command below to switch home configuration
      # nix run . switch -- --flake . --impure 
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.${currentUser} =
          homeConfiguration.byName currentUser;
      };

      # run command below to switch system configuration
      # sudo nixos-rebuild switch --flake . --impure
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs unstablepkgs inputs; };
        modules = [ ./system/configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;
    };
}
