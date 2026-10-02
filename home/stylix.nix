{
  config,
  pkgs,
  ...
}:
{
  stylix = {
    # Stylix is opt-in; without this every setting below is ignored.
    enable = true;
    image = ../system/wallpaper.jpg;
    polarity = "dark";
    base16Scheme = ../visuals/theme.yaml;
    targets.bemenu.enable = false;
    # Not used; its stylix module still sets the renamed programs.rofi.font
    # and prints a warning on every switch.
    targets.rofi.enable = false;
  };
  stylix.fonts = {
    monospace = config.stylix.fonts.sansSerif;
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };
  };

}
