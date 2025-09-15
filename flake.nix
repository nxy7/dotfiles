{
  description = "nxyt NixOS and Home Manager configuration";

  outputs =
    {
      self,
      flake-parts,
      home-manager,
      ...
    }@inputs:
    let
      currentUser = builtins.getEnv "USER";
      system = "x86_64-linux";

      pkgsConfig = {
        allowUnfree = true;
        cudaSupport = true;
        allowUnfreePredicate = (_: true);
        permittedInsecurePredicate = (_: true);
        permittedInsecurePackages = [
          "qtwebengine-5.15.19"
          "electron-25.9.0"
          "python-2.7.18.6"
          "libxml2-2.13.8"
        ];
      };

      pkgs = import inputs.nixpkgs {
        inherit system;
        config = pkgsConfig;
        overlays = import ./overlays.nix { inherit inputs system pkgsConfig; };
      };

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem =
        {
          config,
          system,
          pkgs,
          self',
          ...
        }:
        {
          # packages.default = homeConfig
        };
      flake = {
        homeConfigurations = {
          default = inputs.home-manager.defaultPackage.${system};
          nxyt =
            (import ./home currentUser {
              inherit home-manager inputs pkgs;
            }).mainpc;
          laptop =
            (import ./home currentUser {
              inherit home-manager inputs pkgs;
            }).laptop;
        };

        nixosConfigurations = with inputs.nixpkgs.lib; {
          nixos = nixosSystem {
            inherit system pkgs;
            specialArgs = inputs // {
              inherit inputs;
            };
            modules = [ ./system ];
          };
        };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://ai.cachix.org"
      "https://nix-community.cachix.org"
      "https://roc-lang.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "roc-lang.cachix.org-1:6lZeqLP9SadjmUbskJAvcdGR2T5ViR57pDVkxJQb8R4="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";

    flake-parts.url = "github:hercules-ci/flake-parts";

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    expert.url = "github:elixir-lang/expert";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
