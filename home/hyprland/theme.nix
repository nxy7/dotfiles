{ pkgs, inputs, ... }:
let
  nerdfonts = (pkgs.nerdfonts.override {
    fonts = [
      "Ubuntu"
      "UbuntuMono"
      #     "CascadiaCode"
      #     "FantasqueSansMono"
      #     "FiraCode"
      #     "Mononoki"
    ];
  });

  cursor-theme = "Qogir";
in {
  imports = [ ];
  home = {
    packages = with pkgs; [
      nerdfonts
      swww
      kora-icon-theme
      cantarell-fonts
      font-awesome

      morewaita-icon-theme
      adwaita-icon-theme
      papirus-icon-theme

      adw-gtk3
    ];
    sessionVariables = {
      XCURSOR_THEME = cursor-theme;
      XCURSOR_SIZE = "24";
    };
    file = { ".local/share/wallpapers" = { source = ./wallpapers; }; };
  };

  gtk = { enable = true; };
  # home.file = {
  #   ".local/share/themes/${theme.name}" = {
  #     source = "${theme.package}/share/themes/${theme.name}";
  #   };
  # };

  qt = { enable = true; };
}
