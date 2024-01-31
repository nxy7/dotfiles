{ pkgs, inputs, ... }:
let
  # gtk-theme = "adw-gtk3-dark";

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

  cursor-theme = "Qogir";
  cursor-package = pkgs.qogir-icon-theme;
in {
  imports = [ ];
  home = {
    packages = with pkgs; [
      nerdfonts
      swww
      # font-awesome
      # moreWaita
      # adwaita-qt
      kora-icon-theme

      adw-gtk3
      # papirus-icon-theme
      # qogir-icon-theme
      # whitesur-icon-theme
      # colloid-icon-theme
      # qogir-theme
      # yaru-theme
      # whitesur-gtk-theme
      # orchis-theme
    ];
    sessionVariables = {
      XCURSOR_THEME = cursor-theme;
      XCURSOR_SIZE = "24";
    };
    # pointerCursor = {
    #   package = cursor-package;
    #   name = cursor-theme;
    #   size = 24;
    #   gtk.enable = true;
    # };
    file = {
      # ".local/share/fonts" = {
      #   recursive = true;
      #   source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
      # };
      # ".fonts" = {
      #   recursive = true;
      #   source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
      # };
      # ".config/gtk-4.0/gtk.css" = {
      #   text = ''
      #     window.messagedialog .response-area > button,
      #     window.dialog.message .dialog-action-area > button,
      #     .background.csd{
      #       border-radius: 0;
      #     }
      #   '';
      # };
      # ".local/share/icons/MoreWaita" = { source = "${moreWaita}/share/icons"; };
      # ".local/share/icons/Kora" = {
      #   source = "${pkgs.kora-icon-theme}/share/icons";
      # };
      ".local/share/wallpapers" = { source = ./wallpapers; };
    };
  };

  gtk = {
    enable = true;
    # theme.name = gtk-theme;
    iconTheme.name = "kora";
    # iconTheme.package = pkgs.kora-icon-theme;
    iconTheme.package = pkgs.kora-icon-theme;
  };

  qt = {
    enable = true;
    # platformTheme = "kde";
  };
}
