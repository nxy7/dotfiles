{ pkgs, inputs, ... }:
let
  moreWaita = pkgs.stdenv.mkDerivation {
    name = "MoreWaita";
    src = inputs.more-waita;
    installPhase = ''
      mkdir -p $out/share/icons
      mv * $out/share/icons
    '';
  };

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
  theme = {
    name = "MoreWaita";
    package = moreWaita;
  };

  cursor-theme = "Qogir";
in {
  imports = [ ];
  home = {
    packages = with pkgs; [
      nerdfonts
      swww
      # kora-icon-theme
      cantarell-fonts
      font-awesome
      morewaita-icon-theme
      gnome.adwaita-icon-theme
      papirus-icon-theme

      adw-gtk3
    ];
    sessionVariables = {
      XCURSOR_THEME = cursor-theme;
      XCURSOR_SIZE = "24";
    };
    file = { ".local/share/wallpapers" = { source = ./wallpapers; }; };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = theme.name;
      package = theme.package;
    };

  };
  home.file = {
    ".local/share/themes/${theme.name}" = {
      source = "${theme.package}/share/themes/${theme.name}";
    };
    # ".config/gtk-4.0/gtk.css".text = ''
    #   window.messagedialog .response-area > button,
    #   window.dialog.message .dialog-action-area > button,
    #   .background.csd{
    #     border-radius: 0;
    #   }
    # '';
  };

  qt = { enable = true; };
}
