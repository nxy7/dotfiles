{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.<plugin>
    ];
  };
}
