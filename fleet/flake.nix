{
  description = "Self-hosted GitHub Actions runner on the Gigabyte G5 laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, nixos-hardware, ... }:
    {
      nixosConfigurations.g5-runner = nixpkgs.lib.nixosSystem {
        modules = [
          # Headless runner: power the RTX 4060 off entirely so it can't sit
          # awake drawing idle power around the clock.
          nixos-hardware.nixosModules.common-gpu-nvidia-disable

          ./g5-runner/hardware-configuration.nix
          ./g5-runner/configuration.nix
          ./g5-runner/runners.nix
        ];
      };
    };
}
