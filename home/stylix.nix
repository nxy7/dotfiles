{
  config,
  pkgs,
  ...
}:
{
  stylix = {
    image = ../system/wallpaper.jpg;
    polarity = "dark";
    base16Scheme = ../visuals/theme.yaml;
    targets.bemenu.enable = false;
  };
  stylix.fonts = {
    monospace = config.stylix.fonts.sansSerif;
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = (
        pkgs.nerd-fonts.override {
          fonts = [
            "Monaspace"
            "RobotoMono"
            "DejaVuSansMono"
            "FiraCode"
          ];
        }
      );
      name = "Fira Code Nerd Font";
    };
  };

}
