{ pkgs, inputs, config, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
  };
}
