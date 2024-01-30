{ stablepkgs, pkgs, inputs, ... }: {
  home.packages = with pkgs;
    [
      x2goclient
      wacomtablet

      lnav
      insomnia
      redis
      bashInteractive
      sqlite
      kicad
      yazi
      qmk
      hwinfo
      mangohud
      gimp-with-plugins

      gtk3
      papirus-icon-theme
      transmission_4-gtk
      gnome.nautilus

      grim
      slurp

      cura

      libglvnd
      lxqt.libqtxdg
      egl-wayland

      gnumake
      ginkgo
      buildah-unwrapped
      pomodorust
      fzf

      cilium-cli

      cmake
      llvmPackages_latest.llvm
      rocmPackages.llvm.clang

      nix-prefetch-github
      pgweb
      du-dust
      hyperfine
      htop
      gitui
      # porsmo

      pueue
      keepassxc
      ventoy
      cachix
      freshfetch

      k9s
      kustomize
      kube3d
      kubectl
      colorls
      bat
      ripgrep

    ] ++ (with stablepkgs; [ obsidian hugo ]);
}

