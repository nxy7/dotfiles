{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    x2goclient
    wacomtablet
    mission-center
    lnav
    insomnia
    redis
    bashInteractive
    sqlite
    kicad
    yazi
    qmk
    gnome.nautilus

    grim
    slurp

    cura
    obsidian

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

    hugo
    k9s
    kustomize
    kube3d
    kubectl
    colorls
    bat
    ripgrep

  ];
}

