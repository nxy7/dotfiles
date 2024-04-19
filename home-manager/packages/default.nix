{ pkgs, inputs, fullSystem, ... }:
let
  packages = with pkgs;
    [ speechd yazi bat ripgrep k9s kustomize kube3d kubectl ]
    ++ lib.optionals (fullSystem) [
      obsidian
      # steel

      chatgpt-cli
      buf
      fd
      tlrc
      omnisharp-roslyn

      vscode

      grpcui
      grpcurl
      wacomtablet

      lnav
      kicad

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

      cachix
      keepassxc

    ];
in { home.packages = packages; }

