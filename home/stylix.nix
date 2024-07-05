{ config, inputs, pkgs, ... }: {
  stylix = {
    # image = ../hyprland/wallpapers/1.jpg;
    polarity = "dark";
    base16Scheme = ../theme.yaml;
    targets.bemenu.enable = false;
    # autoEnable = true;
  };
  stylix.fonts = {
    monospace = config.stylix.fonts.sansSerif;
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = (pkgs.nerdfonts.override {
        fonts = [ "Monaspace" "RobotoMono" "DejaVuSansMono" ];
      });
      name = "Monaspace Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

}
