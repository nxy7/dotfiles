{ pkgs, fullSystem, ... }: {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      ventoy
      foot
      hyperfine
      multitime
      qmk
      just
      speechd
      guvcview
      warp-terminal
      figma-linux
      murex

      kooha
      flameshot
      satty

      k6
      deno
      wrk

      grpcurl
      grpcui
      bloomrpc
      diffutils

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
      watchexec
      htop

      cachix
      keepassxc
      keepass-keeagent

      pgweb

      tokei
    ];
}

