{ inputs, system }:
let
  stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
    config.allowUnfreePredicate = (_: true);
    config.permittedInsecurePredicate = (_: true);
    config.permittedInsecurePackages = [
      "electron-24.8.6"
      "electron-25.9.0"
      "python-2.7.18.6"
      "electron-24.8.6"
    ];
  };

  fromFlakes = { steel = inputs.steel.packages.${system}.steel; };

  stablePkgs = with stable; { inherit obs-studio jetbrains; };
in [
  (final: prev:
    {
      utillinux = prev.util-linux;
      obsidian = (prev.obsidian.override { electron = prev.electron_24; });
      zen-browser = inputs.zen-browser.packages.x86_64-linux.default;
      # zen-browser-specific = inputs.zen-browser.packages.x86_64-linux.specific;
      # zen-browser-generic = inputs.zen-browser.packages.x86_64-linux.generic;
    } // fromFlakes // stablePkgs)
]
