{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    # hardware-info.url = "/etc/nixos/hardware-configuration.nix";
  };


  outputs = inputs@{ self, nixpkgs, ... }:
    # let
    #   pkgs = import nixpkgs{};
    # in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = inputs;
        modules = [ ./configuration.nix ];
      };

      nixosConfigurations.default = self.nixosConfigurations.nixos;

    };
}
