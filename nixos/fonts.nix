{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    # nerdfonts
    (pkgs.nerdfonts.override {
      fonts = [
        "Ubuntu"
        "DejaVuSansMono"
        # "UbuntuMono"
        # "CascadiaCode"
        # "FantasqueSansMono"
        "FiraCode"
        # "Mononoki"
        # "Iosevka"
      ];
    })
    dejavu_fonts
    # noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji

    # liberation_ttf
    # fira-code
    # fira-code-symbols
    # mplus-outline-fonts.githubRelease
    # dina-font
    # proggyfonts
  ];

}
