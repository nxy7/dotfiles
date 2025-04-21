{ inputs, system }:
let
  stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
    config.allowUnfreePredicate = (_: true);
    config.permittedInsecurePredicate = (_: true);
    config.permittedInsecurePackages = [ "electron-25.9.0" "python-2.7.18.6" ];
  };
  old = import inputs.nixpkgs-old {
    inherit system;
    config.allowUnfree = true;
    config.allowUnfreePredicate = (_: true);
    config.permittedInsecurePredicate = (_: true);
    config.permittedInsecurePackages = [ "electron-25.9.0" "python-2.7.18.6" ];
  };

  fromFlakes = {
    elk = inputs.elk.packages.${system}.elk;
    # zed-editor = inputs.zed-editor.packages.${system}.default;
  };

  stablePkgs = with stable;
    {
      # inherit azure-cli;
    };
  oldPkgs = with old; { inherit jetbrains; };

  overlayPkgs = (final: prev:
    {
      utillinux = prev.util-linux;
      zen-browser = inputs.zen-browser.packages.${system}.default;
    } // fromFlakes // stablePkgs // oldPkgs);
in [
  overlayPkgs
  inputs.hyprpanel.overlay
  # inputs.zed-editor.overlays.default
]
