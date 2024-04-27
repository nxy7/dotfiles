{ pkgs, fullSystem, ... }:
let
  packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      speechd
      obsidian
      # steel
      racket

      chatgpt-cli

      # vscode
      omnisharp-roslyn

      wacomtablet

      lnav
      kicad

      qmk
      hwinfo
      mangohud

      gimp
      gnome.nautilus

      htop

      cachix
      keepassxc

      pgweb

      # 3D Printing
      cura
    ];
in {
  home.packages = packages;
  programs.yazi.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.k9s.enable = true;
}

