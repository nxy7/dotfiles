{
  description = "nxyt NixOS and Home Manager configuration";

  outputs = { self, flake-parts, home-manager, ... }@inputs:
    let
      currentUser = builtins.getEnv "USER";
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePredicate = (_: true);
        config.permittedInsecurePackages = [
          "electron-24.8.6"
          "electron-25.9.0"
          "python-2.7.18.6"
          "electron-24.8.6"
          "dotnet-runtime-6.0.36"
          "dotnet-sdk-wrapped-6.0.428"
          "dotnet-sdk-6.0.428"
        ];
        overlays = import ./overlays.nix { inherit inputs system; };
      };

    in flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, system, pkgs, self', ... }:
        {
          # packages.default = homeConfig
        };
      flake = {
        homeConfigurations = {
          default = inputs.home-manager.defaultPackage.${system};
          nxyt = (import ./home currentUser {
            inherit home-manager inputs pkgs;
          }).mainpc;
          laptop = (import ./home currentUser {
            inherit home-manager inputs pkgs;
          }).laptop;
        };

        nixosConfigurations = with inputs.nixpkgs.lib; {
          nixos = nixosSystem {
            inherit system pkgs;
            specialArgs = inputs // { inherit inputs; };
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
      "https://zed-industries.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "roc-lang.cachix.org-1:6lZeqLP9SadjmUbskJAvcdGR2T5ViR57pDVkxJQb8R4="
      "zed-industries.cachix.org-1:QW3RoXK0Lm4ycmU5/3bmYRd3MLf4RbTGPqRulGlX5W0="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-old.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";

    flake-parts.url = "github:hercules-ci/flake-parts";

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    sops-nix.url = "github:Mic92/sops-nix";

    roc.url = "github:roc-lang/roc";
    roc-start.url = "github:nxy7/roc-start/add-nix-support";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zed-editor.url = "github:zed-industries/zed";
    elk.url = "github:PaddiM8/elk";

  };
}
