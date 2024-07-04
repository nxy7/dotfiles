{ pkgs, inputs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
      hyprpanel
      # inputs.aylurDots.packages.x86_64-linux.default
      waybar
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

      hyprpicker
      grimblast
      grim
      slurp
      swappy
      ksnip

      which
      dart-sass
      fd
      fzf
      brightnessctl
      swww
      matugen
      slurp
      wf-recorder
      wl-clipboard
      wayshot
      swappy
      hyprpicker
      pavucontrol
      networkmanager
      gtk3
      glib
      libsoup_3
      papirus-icon-theme
      gnome.adwaita-icon-theme

      libadwaita
    ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
  };
}
