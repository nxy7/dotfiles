{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstablePkgs.url = "nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix";
    hyprland.url = "github:hyprwm/Hyprland";
    tailwindcss-lsp.url = "github:nxy7/tailwindcss-intellisense";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, flake-parts, home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      currentUser = builtins.getEnv "USER";

      insecurePackages = [ "electron-25.9.0" "python-2.7.18.6" ];

      # nixpkgs
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePackages = insecurePackages;
        overlays = import ./overlays.nix { inherit inputs system; };
      };
      unstablepkgs = import inputs.unstablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePackages = insecurePackages;
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      # other utilities
      homeConfiguration = import ./home-manager/homeConfiguration.nix {
        inherit home-manager inputs pkgs unstablepkgs;
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
        modules =
          [ inputs.hyprland.nixosModules.default ./nixos/configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;
    };
}
