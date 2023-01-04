{ inputs, pkgs, config, ... }:
let
  icons = rec {
    calendar = "󰃭 ";
    clock = " ";
    battery.charging = "󱐋";
    battery.horizontal = [ " " " " " " " " " " ];
    battery.vertical = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
    battery.levels = battery.vertical;
    network.disconnected = "󰤮 ";
    network.ethernet = "󰈀 ";
    network.strength = [ "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
    bluetooth.on = "󰂯";
    bluetooth.off = "󰂲";
    bluetooth.battery = "󰥉";
    volume.source = "󱄠";
    volume.muted = "󰝟";
    volume.levels = [ "󰕿" "󰖀" "󰕾" ];
    idle.on = "󰈈 ";
    idle.off = "󰈉 ";
    vpn = "󰌆 ";

    notification.red_badge = "<span foreground='red'><sup></sup></span>";
    notification.bell = "󰂚";
    notification.bell-badge = "󱅫";
    notification.bell-outline = "󰂜";
    notification.bell-outline-badge = "󰅸";
  };
in {
  imports = [ inputs.niri.nixosModules.niri ];

  config = {
    services.xserver = { enable = true; };
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "nxyt";

    environment.variables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      wayland-utils
      libsecret
      libnotify
      alacritty
      cage
      gamescope
      fuzzle
      xwayland-satellite-unstable
      swaybg
      swaylock
    ];

    # services.mako = {
    #   enable = true;
    #   borderRadius = 8;
    #   format = "%a\n%s\n%b";
    # };

  };
}
