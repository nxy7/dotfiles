{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    betapkgs.url = "nixpkgs/nixos-unstable";
    # hardware-info.url = "/etc/nixos/hardware-configuration.nix";
  };

  outputs = inputs@{ self, nixpkgs, betapkgs, ... }:
    let
      system = "x86_64-linux";
      overlays = [ ];
      config = {
        allowUnfree = true;
        permittedInsecurePackages =
          [ "electron-12.2.3" "electron-12.2.3" "python-2.7.18.6" ];
      };
      pkgs = import nixpkgs { inherit overlays config; };
      betaPkgs = import betapkgs { inherit overlays config; };
    in {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs betaPkgs; };
        modules = [ ./configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;

    };
}
