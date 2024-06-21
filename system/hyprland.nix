{ pkgs, inputs, ... }: {

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = { enable = true; };
  };

  services.xserver.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "where_is_my_sddm_theme";
    autoLogin = {
      user = "nxyt";
      enable = true;
    };
    # autoLogin = {
    #   enable = true;
    #   user = "nxyt";
    # };
  };
  # services.xrdp.enable = true;
  # services.gnome.gnome-remote-desktop.enable = true;

  # services.xrdp.defaultWindowManager = "startplasma-x11";
  # services.xrdp.openFirewall = true;

  environment.systemPackages = with pkgs; [
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
