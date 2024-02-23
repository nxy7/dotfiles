{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [ "Ubuntu" "DejaVuSansMono" "FiraCode" ];
    })
    dejavu_fonts
  ];

}
