{ pkgs, fullSystem, ... }:
let
  packages = with pkgs;
    [ yazi bat ripgrep k9s kustomize kube3d kubectl fd fzf ]
    ++ lib.optionals (fullSystem) [
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
in { home.packages = packages; }

