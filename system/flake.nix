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
        };
        overlays = [  ];
      };
      betaPkgs = import betapkgs {
        config = {
          allowUnfree = true;
        };
        overlays = [  ];
      };
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs betaPkgs; };
        modules = [ ./configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;

    };
}
