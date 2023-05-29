{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    # hardware-info.url = "/etc/nixos/hardware-configuration.nix";
  };


  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
        };
      };
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit pkgs; };
        modules = [ ./configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;

    };
}
