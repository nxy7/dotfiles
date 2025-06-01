{
  inputs,
  system,
  pkgsConfig,
}:
let
  stable = import inputs.nixpkgs-stable {
    inherit system;
    config = pkgsConfig;
  };

  fromFlakes = {
    expert = inputs.expert.packages.${system}.default;
  };

  stablePkgs = with stable; {
    inherit azure-cli slack flameshot;
  };

  overlayPkgs = (
    final: prev:
    {
      utillinux = prev.util-linux;
      zen-browser = inputs.zen-browser.packages.${system}.default;
    }
    // fromFlakes
    // stablePkgs
  );
in
[ overlayPkgs ]
