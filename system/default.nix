{ pkgs ? import <nixpkgs>, unstablepkgs, system, inputs, ... }: rec {
  nixosConfigurations.nixos = pkgs.lib.nixosSystem {
    inherit system;
    specialArgs = inputs // { inherit pkgs unstablepkgs inputs; };
    modules = [ ./configuration.nix ];
  };

  environment.etc.test = {
    text = "elo";
    mode = "0440";
  };

  environment.etc.someotherfile = {
    text = "elo";
    mode = "0440";
  };

  nixosConfigurations.default = nixosConfigurations.nixos;

}
