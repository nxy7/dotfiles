{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code-symbols
    dejavu_fonts
  ];

}
