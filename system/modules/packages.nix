{ pkgs, config, inputs, system, ... }: {
  environment.systemPackages = (with pkgs; [
    zip
    sops
    speechd
    espeak
    home-manager
    appimage-run
    busybox
    lsof
    unzip
    openssl
    jq
    yq

    distrobox

    stremio
    zip
    libreoffice-qt

    xclip
    wl-clipboard
    vlc

    usbutils
    git
    helix
    vivaldi

    wineWowPackages.stable
    wezterm
    kitty

    steam-run

    goxlr-utility

    mission-center
    # nvtop-nvidia
    # nvtopPackages.nvidia
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
  ]);
}
