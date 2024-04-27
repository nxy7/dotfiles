{
  description = "nxyt NixOS and Home Manager configuration";

  outputs = { self, flake-parts, home-manager, ... }@inputs:
    let
      currentUser = builtins.getEnv "USER";
      system = "x86_64-linux";

      pkgs = import inputs.stablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePredicate = (_: true);
        config.permittedInsecurePackages =
          [ "electron-24.8.6" "electron-25.9.0" "python-2.7.18.6" ];
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      homeConfiguration =
        import ./home-manager currentUser { inherit home-manager inputs pkgs; };
      minimalHomeConfiguration = import ./home-manager currentUser {
        inherit home-manager inputs pkgs;
        fullSystem = false;
      };
      inherit (inputs.stablePkgs.lib) nixosSystem;
    in flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, system, pkgs, self', ... }: { };
      flake = {
        homeConfigurations = {
          default = inputs.home-manager.defaultPackage.${system};
          "nxyt" = homeConfiguration;
        };

        nixosConfigurations = {
          nixos = nixosSystem {
            inherit system;
            specialArgs = inputs // { inherit pkgs inputs; };
            modules = [ inputs.hyprland.nixosModules.default ./nixos ];
          };
          # mainpi = nixosSystem {
          #   inherit system;
          #   specialArgs = inputs // { inherit pkgs inputs; };
          #   modules = [ ./servers/mainpi ];
          # };
          # printServer = nixosSystem {
          #   inherit system;
          #   specialArgs = inputs // { inherit pkgs inputs; };
          #   modules = [ ./servers/mainpi ];
          # };
          # contaboVpn = nixosSystem {
          #   inherit system;
          #   specialArgs = inputs // { inherit pkgs inputs; };
          #   modules = [ ./servers/contaboVpn ];
          # };
        };
      };
    };

  inputs = {
    unstablePkgs.url = "nixpkgs/nixos-unstable";
    # for now the unstable and stable are the same, once 24.05 lands stable will be set to 24.05
    stablePkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "stablePkgs";

    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "stablePkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "stablePkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "stablePkgs";
    astal.url = "github:Aylur/astal";
    astal.inputs.nixpkgs.follows = "stablePkgs";
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "stablePkgs";
    };
    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "stablePkgs";

    steel.url = "github:mattwparas/steel";

    matugen.url = "github:InioX/matugen";

  };
}
