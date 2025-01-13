{ inputs, pkgs, fullSystem, ... }: {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      # inputs.roc-start.packages.x86_64-linux.default
      vulkan-tools

      goldwarden
      proton-pass
      bombardier
      jetbrains.rider
      ollama
      slumber
      brotli
      imagemagick
      nixd

      ventoy
      hyperfine
      qmk
      just
      figma-linux

      kooha

      k6
      deno
      wrk
      livebook

      grpcurl
      grpcui
      bloomrpc
      diffutils

      unrar
      eza
      fd
      obsidian

      aichat
      discord
      qbittorrent
      aider-chat

      lutris
      # heroic
      chatgpt-cli

      vscode
      lnav

      mangohud

      gimp
      watchexec
      htop
      btop

      cachix
      keepassxc
      keepass-keeagent

      pgweb

      tokei
    ];
}

