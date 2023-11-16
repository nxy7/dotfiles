{ pkgs, ... }: {
  programs.broot = {
    enable = true;
    package = pkgs.broot;

    settings = {

    };
  };
}
