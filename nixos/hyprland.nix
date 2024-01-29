{ pkgs, inputs, ... }:
let
  hyprlandPackage = inputs.hyprland.packages.${pkgs.system}.hyprland;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  username = "nxyt";
in {

  services.getty = {
    autologinUser = "nxyt";
    greetingLine = "Wanna try some 'inux";
  };
  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "${hyprlandPackage}/bin/Hyprland";
  #       user = username;
  #     };
  #     default_session = {
  #       command =
  #         "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${hyprlandPackage}/bin/Hyprland";
  #       user = "greeter";
  #     };

  #   };
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

    polkit-kde-agent

    where-is-my-sddm-theme

    hyprpaper

    # audio gui
    pavucontrol

    # program launcher
    tofi

    # screen sharing
    # pipewire
    wireplumber
    # swaybg
    # wpaperd
    # mpvpaper
    # eww
  ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
      # xdg-desktop-portal-hyprland
    ];
  };
}
