{ pkgs, ... }: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      wlrobs
      obs-tuna
      # obs-multi-rtmp
    ];
  };
}
