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

  cursor-theme = "Qogir";
in {
  imports = [ ];
  home = {
    packages = with pkgs; [
      nerdfonts
      swww
      kora-icon-theme

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
    iconTheme.name = "kora";
    iconTheme.package = pkgs.kora-icon-theme;
  };

  qt = { enable = true; };
}
