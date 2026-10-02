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

  stablePkgs = with stable; {
    inherit
      azure-cli
      slack
      flameshot
      jetbrains
      zed-editor
      ;
  };

  overlayPkgs = (
    final: prev:
    {
      # utillinux = prev.util-linux;
      zen-browser = inputs.zen-browser.packages.${system}.default;
    }
    // stablePkgs
  );
in
[
  overlayPkgs
]
