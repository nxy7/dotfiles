{
  pkgs,
  config,
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      protonvpn-gui
      ghostty
      zip
      sops
      speechd
      home-manager
      # appimage-run
      busybox
      lsof
      unzip

      # distrobox

      # stremio
      libreoffice-qt

      xclip
      wl-clipboard
      vlc

      usbutils
      git
      helix

      steam-run
      goxlr-utility

      # For URL handling and browser redirection
      xdg-utils

    ]
  );
}
