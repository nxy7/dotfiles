{ pkgs, inputs, ... }:
let hyprlandPackage = inputs.hyprland.packages.${pkgs.system}.hyprland;
in {

  # services.getty = {
  #   autologinUser = "nxyt";
  #   greetingLine = "Wanna try some 'inux";
  # };

  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    package = hyprlandPackage;
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.systemPackages = with pkgs; [
    jq
    where-is-my-sddm-theme
    hyprpaper
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
