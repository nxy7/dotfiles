{ pkgs ? import <nixpkgs>, unstablepkgs, system, inputs, ... }: rec {
  nixosConfigurations.nixos = pkgs.lib.nixosSystem {
    inherit system;
    specialArgs = inputs // { inherit pkgs unstablepkgs inputs; };
    modules = [ ./configuration.nix ];
  };

  nixosConfigurations.default = nixosConfigurations.nixos;

}
