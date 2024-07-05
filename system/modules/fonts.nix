{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "Ubuntu" "FiraCode" "Monaspace" ]; })
    dejavu_fonts
  ];

}
