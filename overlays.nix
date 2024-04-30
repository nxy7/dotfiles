{ inputs, system }:
let
  stable = import inputs.nixpkgs {
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

  fromFlakes = {
    steel = inputs.steel.packages.${system}.steel;
    # ags = inputs.ags.packages.${system}.default;
    # wezterm = inputs.wezterm.packages.${system}.default;
  };

  # unstablePkgs = with unstable; {
  #   inherit matugen prisma-engines zed-editor spacedrive morewaita-icon-theme
  #     vscode warp-terminal;
  # };
  stablePkgs = with stable; { inherit obs-studio; };
in [
  (final: prev:
    {
      obsidian = (prev.obsidian.override { electron = prev.electron_24; });
    } // fromFlakes // stablePkgs)
]
