{
  description = "nxyt NixOS and Home Manager configuration";

  outputs =
    {
      self,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # CUDA is enabled per package (e.g. home/obs-studio.nix), not here:
      # a global cudaSupport rebuilds everything that reads it, uncached.
      pkgsConfig = {
        allowUnfree = true;
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
    {
      homeConfigurations = {
        nxyt = import ./home { username = "nxyt"; } {
          inherit home-manager inputs pkgs;
        };

        dawiddanieluk = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };

          extraSpecialArgs = {
            inherit inputs;
            username = "dawiddanieluk";
            isDarwin = true;
            isLinux = false;
          };

          modules = [
            ./home/homesettings.nix
            ./home/nushell.nix
            ./home/helix.nix
            ./home/git.nix
            ./home/work.nix
            ./home/packages.nix
            ./home/services.nix
            ./home/programs.nix

            {
              home.username = "dawiddanieluk";
              home.homeDirectory = "/Users/dawiddanieluk";
            }
          ];
        };
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

      darwinConfigurations."dawiddanieluk" = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [ ./darwin ];
      };
    };

  # Binary caches live in system config (system/default.nix for NixOS), not
  # in nixConfig: flake nixConfig is ignored for non-trusted users (the macOS
  # account) and just produces warnings there.

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    base16.url = "github:SenchoPens/base16.nix";
    base16.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };
}
