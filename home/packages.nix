{ pkgs, fullSystem, ... }: {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      foot
      qmk
      just
      speechd
      guvcview
      warp-terminal
      figma-linux
      kooha

      grpcurl
      grpcui
      bloomrpc

      unrar
      eza
      fd
      obsidian
      zed-editor
      aichat
      discord
      qbittorrent-qt5

      # game launchers
      lutris
      heroic
      davinci-resolve
      chatgpt-cli

      vscode
      lnav

      mangohud

      gimp
      htop

      cachix
      keepassxc

      pgweb

      tokei
    ];
}

