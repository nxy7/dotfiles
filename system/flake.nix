{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    betapkgs.url = "nixpkgs/nixos-23.05";
    # hardware-info.url = "/etc/nixos/hardware-configuration.nix";
  };

  outputs = inputs@{ self, nixpkgs, betapkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-12.2.3" ];
        };
        overlays = [ ];
      };
      betaPkgs = import betapkgs {
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-12.2.3" "python-2.7.18.6" ];
        };
        overlays = [ ];
      };
    in {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs betaPkgs; };
        modules = [ ./configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;

    };
}
