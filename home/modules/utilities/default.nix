{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    x2goclient
    wacomtablet
    lnav
    insomnia
    redis
    bashInteractive
    sqlite
    kicad
    qmk

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

