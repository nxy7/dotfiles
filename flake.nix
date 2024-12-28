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
          # packages.default = homeConfig;
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
      "https://ghostty.cachix.org"
      "https://roc-lang.cachix.org"
      # "https://cosmic.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "roc-lang.cachix.org-1:6lZeqLP9SadjmUbskJAvcdGR2T5ViR57pDVkxJQb8R4="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    sops-nix.url = "github:Mic92/sops-nix";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    # niri.url = "github:sodiboo/niri-flake";
    roc.url = "github:roc-lang/roc";
    roc-start.url = "github:nxy7/roc-start/add-nix-support";

    # cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

}

