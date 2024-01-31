{ config, inputs, pkgs, ... }: {
  stylix = {
    image = ../hyprland/wallpapers/1.jpg;
    polarity = "dark";
    base16Scheme = ../../theme.yaml;
  };
  stylix.fonts = {
    monospace = config.stylix.fonts.sansSerif;
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = (pkgs.nerdfonts.override {
        fonts = [ "RobotoMono" "DejaVuSansMono" ];
      });
      name = "Roboto Mono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

}
