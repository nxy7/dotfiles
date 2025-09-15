{ pkgs, inputs, ... }:
{
  imports = [ ];

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpanel
    morewaita-icon-theme
    qogir-icon-theme
    loupe
    # baobab
    # gnome-text-editor
    # gnome-calendar
    # gnome-boxes
    # gnome-system-monitor
    # gnome-control-center
    # gnome-weather
    # gnome-calculator
    # gnome-clocks
    # gnome-software # for flatpak
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
    # gnome.adwaita-icon-theme

    libadwaita
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
}
