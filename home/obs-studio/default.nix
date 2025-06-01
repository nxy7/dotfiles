{ pkgs, config, ... }: {
  programs.obs-studio = {
    enable = true;
    package = (pkgs.obs-studio.override { cudaSupport = true; });

    plugins = with pkgs.obs-studio-plugins;
      [
        # obs-vkcapture
        # wlrobs
        # obs-tuna
        # obs-multi-rtmp
      ];
  };
}
