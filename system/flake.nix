{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    # hardware-info.url = "/etc/nixos/hardware-configuration.nix";
  };


  outputs = { self, nixpkgs }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };

    nixosConfigurations.default = self.nixosConfigurations.nixos;

  };
}
