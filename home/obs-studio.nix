{ pkgs, config, lib, isLinux ? pkgs.stdenv.isLinux, ... }:
{
  programs.obs-studio = lib.mkIf isLinux {
    enable = true;
    # package = (pkgs.obs-studio.override { cudaSupport = true; });

    plugins = with pkgs.obs-studio-plugins; [
      # obs-vkcapture
      # wlrobs
      # obs-tuna
      # obs-multi-rtmp
    ];
  };
}
