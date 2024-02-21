{ stablepkgs, pkgs, inputs, ... }:
let
  stable = with stablepkgs; [ hugo ];
  unstable = with pkgs; [
    (obsidian.override { electron = stablepkgs.electron_24; })
    activitywatch

    xonsh
    xxh

    wacomtablet

    lnav
    insomnia
    kicad
    yazi
    qmk
    hwinfo
    mangohud
    gimp-with-plugins

    gtk3
    transmission_4-gtk
    gnome.nautilus

    cura

    pomodorust
    fzf

    cilium-cli

    cmake
    llvmPackages_latest.llvm
    rocmPackages.llvm.clang

    pgweb
    du-dust
    hyperfine
    htop
    gitui

    pueue
    keepassxc
    # ventoy
    cachix

    k9s
    kustomize
    kube3d
    kubectl
    colorls
    bat
    ripgrep

  ];
in { home.packages = stable ++ unstable; }

