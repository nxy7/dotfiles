{
  description = "nxyt NixOS and Home Manager configuration";

  outputs = { self, flake-parts, home-manager, ... }@inputs:
    let
      currentUser = builtins.getEnv "USER";
      system = "x86_64-linux";

      pkgs = import inputs.unstablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePredicate = (_: true);
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      homeConfig =
        import ./home-manager currentUser { inherit home-manager inputs pkgs; };
      inherit (inputs.unstablePkgs.lib) nixosSystem;
    in flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, system, pkgs, self', ... }: { };
      flake = {
        homeConfigurations = {
          default = inputs.home-manager.defaultPackage.${system};
          "${currentUser}" = homeConfig;
        };

        nixosConfigurations = {
          nixos = nixosSystem {
            inherit system;
            specialArgs = inputs // { inherit pkgs inputs; };
            modules = [ inputs.hyprland.nixosModules.default ./nixos ];
          };
        };
      };
    };

  inputs = {
    unstablePkgs.url = "nixpkgs/nixos-unstable";
    stablePkgs.url = "nixpkgs/nixos-23.11";

    helix.url = "github:helix-editor/helix";
    hyprland.url = "github:hyprwm/Hyprland";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "unstablePkgs";

    steel.url = "github:mattwparas/steel";
    steel.inputs.nixpkgs.follows = "unstablePkgs";

    nvim-github-theme.url = "github:projekt0n/github-nvim-theme";
    nvim-github-theme.flake = false;

    matugen.url = "github:InioX/matugen";

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      # inputs.nixpkgs.follows = "stablePkgs";
    };

  };
}
