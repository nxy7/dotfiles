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
      flake = {
        homeConfigurations = {
          nxyt = (
            import ./home { username = currentUser; } {
              inherit home-manager inputs pkgs;
            }
          );
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
      "https://niri.cachix.org"
      "https://cosmic.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "roc-lang.cachix.org-1:6lZeqLP9SadjmUbskJAvcdGR2T5ViR57pDVkxJQb8R4="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";
    dankMaterialShell.inputs.dgop.follows = "dgop";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };
}
