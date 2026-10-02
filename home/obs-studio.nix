{ pkgs, config, lib, isLinux ? pkgs.stdenv.isLinux, ... }:
{
  programs.obs-studio = lib.mkIf isLinux {
    enable = true;
    # CUDA (NVENC) for OBS only; it's no longer switched on for all packages.
    package = pkgs.obs-studio.override { cudaSupport = true; };

    plugins = with pkgs.obs-studio-plugins; [
      # obs-vkcapture
      # wlrobs
      # obs-tuna
      # obs-multi-rtmp
    ];
  };
}
