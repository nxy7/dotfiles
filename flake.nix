{
  description = "nxyt NixOS and Home Manager configuration";

  outputs = { self, flake-parts, home-manager, ... }@inputs:
    let
      currentUser = builtins.getEnv "USER";
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePredicate = (_: true);
        config.permittedInsecurePackages = [
          "electron-24.8.6"
          "electron-25.9.0"
          "python-2.7.18.6"
          "electron-24.8.6"
        ];
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      homeConfig =
        import ./home-manager currentUser { inherit home-manager inputs pkgs; };
      # inherit (inputs.stablePkgs.lib) nixosSystem;
    in flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, system, pkgs, self', ... }: { };
      flake = {
        homeConfigurations = {
          default = inputs.home-manager.defaultPackage.${system};
          "${currentUser}" = homeConfig;
        };

        nixosConfigurations = with inputs.nixpkgs-unstable.lib; {
          nixos = nixosSystem {
            inherit system;
            specialArgs = inputs // { inherit pkgs inputs; };
            modules = [ ./nixos ];
          };
        };
      };
    };

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    # helix.url = "github:mattwparas/helix";

    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

  };
}
