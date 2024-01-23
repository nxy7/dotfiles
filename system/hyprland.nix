{ pkgs, inputs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    waybar
    mako
    libnotify

    hyprpaper
    rofi-wayland
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
