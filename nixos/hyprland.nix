{ pkgs, inputs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
  };

  services.xserver.enable = true;
  services.xserver.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "where_is_my_sddm_theme";
    autoLogin = {
      enable = true;
      user = "nxyt";
    };
  };
  services.xrdp.enable = true;
  services.gnome.gnome-remote-desktop.enable = true;

  # services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.systemPackages = with pkgs; [
    jq
    where-is-my-sddm-theme
    hyprpaper
    hyprshade
    wf-recorder
    # audio gui
    pavucontrol
    # program launcher
    tofi
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
  };
}
