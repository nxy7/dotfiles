{ pkgs, inputs, ... }:
let
  packages = with pkgs; [
    obsidian
    jetbrains.datagrip
    chatgpt-cli
    buf
    fd
    tlrc
    eza
    yazi
    omnisharp-roslyn
    slack

    xonsh
    elvish

    vscode

    grpcui
    grpcurl
    wacomtablet

    lnav
    insomnia
    kicad
    yazi
    qmk
    hwinfo
    mangohud
    gimp

    gtk3
    transmission_4-gtk
    gnome.nautilus

    nheko
    fractal

    cura

    pomodorust
    fzf

    cilium-cli

    cmake
    llvmPackages_latest.llvm
    rocmPackages.llvm.clang

    pgweb
    du-dust
    hyperfine # cli benchmarking tool
    k6 # http benchmarking tool
    htop
    gitui

    keepassxc
    cachix

    k9s
    kustomize
    kube3d
    kubectl
    bat
    ripgrep

  ];
in { home.packages = packages; }

