{ inputs, pkgs, fullSystem, ... }:
let browsers = with pkgs; [ ungoogled-chromium brave ];

in {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ browsers ++ lib.optionals (fullSystem) [
      inputs.roc-start.packages.x86_64-linux.default
      vulkan-tools
      elk
      fx-cast-bridge
      go-chromecast

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

