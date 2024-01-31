{
  description = "My system configuration";

  inputs = {
    unstablePkgs.url = "nixpkgs/nixos-unstable";
    stablePkgs.url = "nixpkgs/nixos-23.11";

    helix.url = "github:helix-editor/helix";
    hyprland.url = "github:hyprwm/Hyprland";
    tailwindcss-lsp.url = "github:nxy7/tailwindcss-intellisense";
    pomodorust.url = "github:nxy7/pomodorust";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ags.url = "github:Aylur/ags";
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

  };

  outputs = { self, flake-parts, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      currentUser = builtins.getEnv "USER";

      insecurePackages =
        [ "electron-24.8.6" "electron-25.9.0" "python-2.7.18.6" ];

      pkgs = import inputs.unstablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePackages = insecurePackages;
        overlays = import ./overlays.nix { inherit inputs system; };
      };
      stablepkgs = import inputs.stablePkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePackages = insecurePackages;
        overlays = import ./overlays.nix { inherit inputs system; };
      };

      homeConfiguration =
        import ./home-manager { inherit home-manager inputs pkgs stablepkgs; };

    in {
      # run command below to switch home configuration
      # nix run . switch -- --flake . --impure 
      packages.${system} = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations.${currentUser} = homeConfiguration;
      };

      # run command below to switch system configuration
      # sudo nixos-rebuild switch --flake . --impure
      nixosConfigurations.nixos = inputs.unstablePkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs stablepkgs inputs; };
        modules = [ inputs.hyprland.nixosModules.default ./nixos ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;
    };
}
