{
  inputs,
  system,
  pkgsConfig,
}:
let
  old = import inputs.nixpkgs-old {
    inherit system;
    config = pkgsConfig;
  };
  stable = import inputs.nixpkgs-stable {
    inherit system;
    config = pkgsConfig;
  };

  fromFlakes = {
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

  oldPkgs = with old; {
    # inherit nodejs_19;
  };

  overlayPkgs = (
    final: prev:
    {
      # utillinux = prev.util-linux;
      zen-browser = inputs.zen-browser.packages.${system}.default;
    }
    // fromFlakes
    // stablePkgs
    // oldPkgs
  );
in
[
  overlayPkgs
  # inputs.niri.overlays.niri
]
