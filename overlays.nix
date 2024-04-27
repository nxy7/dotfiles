{ inputs, system }:
let
  unstablepkgs = import inputs.unstablePkgs {
    inherit system;
    # config.permittedInsecurePredicate = (_: true);
    config.permittedInsecurePackages =
      [ "electron-24.8.6" "electron-25.9.0" "python-2.7.18.6" ];
  };
in [
  (final: prev:
    {
      obsidian = (prev.obsidian.override { electron = prev.electron_24; });
    } // {
      steel = inputs.steel.packages.${system}.steel;

      # From inputs
      wezterm = inputs.wezterm.packages.${system}.default;
      helix = inputs.helix.packages.${system}.default;
      hyprland = inputs.hyprland.packages.${system}.hyprland;
      pomodorust = inputs.pomodorust.packages.${system}.default;
    } // {
      # from unstable
      nushell = unstablepkgs.nushell.override {
        additionalFeatures = p: [ "dataframe" ];
      };
    })
]
