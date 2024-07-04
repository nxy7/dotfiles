{ pkgs, inputs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
  };

  services.xserver.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "where_is_my_sddm_theme";
  };
  # services.xrdp.enable = true;
  # services.gnome.gnome-remote-desktop.enable = true;

  # services.xrdp.defaultWindowManager = "startplasma-x11";
  # services.xrdp.openFirewall = true;

  environment.systemPackages = with pkgs;
    with gnome; [
      morewaita-icon-theme
      adwaita-icon-theme
      qogir-icon-theme
      loupe
      nautilus
      baobab
      gnome-text-editor
      gnome-calendar
      gnome-boxes
      gnome-system-monitor
      gnome-control-center
      gnome-weather
      gnome-calculator
      gnome-clocks
      gnome-software # for flatpak
      wl-gammactl
      wl-clipboard
      wayshot
      pavucontrol
      brightnessctl
      swww
      jq
      where-is-my-sddm-theme
      hyprpaper
      hyprshade
      wf-recorder
      pavucontrol
    ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
  };
}
