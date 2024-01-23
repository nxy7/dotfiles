{ pkgs, inputs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.systemPackages = with pkgs; [
    eww
    mako
    libnotify
    polkit-kde-agent

    where-is-my-sddm-theme
    dolphin

    hyprpaper
    rofi-wayland

    # audio gui
    pavucontrol

    # program launcher
    tofi

    # screen sharing
    pipewire
    wireplumber
    # swaybg
    # wpaperd
    # mpvpaper
    # eww
  ];
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
  };
}
