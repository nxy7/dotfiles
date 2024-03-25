{ inputs, system }:
let
  stablepkgs = import inputs.stablePkgs {
    inherit system;
    # config.permittedInsecurePredicate = (_: true);
    config.permittedInsecurePackages =
      [ "electron-24.8.6" "electron-25.9.0" "python-2.7.18.6" ];
  };
in [
  (final: prev: {
    helix = inputs.helix.packages.${system}.default;
    hyprland = inputs.hyprland.packages.${system}.hyprland;
    pomodorust = inputs.pomodorust.packages.${system}.default;
    openvpn = stablepkgs.openvpn;
    obsidian = (prev.obsidian.override { electron = stablepkgs.electron_24; });
    steel = inputs.steel.packages.${system}.steel;
  })
]
