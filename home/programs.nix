{ pkgs, fullSystem, ... }:
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
  programs = {
    # yazi.enable = true;
    ripgrep.enable = true;
    bat.enable = true;
    fzf.enable = true;
    k9s.enable = true;
    fish.enable = true;
    fuzzel.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        time.disabled = false;

        memory_usage.disabled = true;
        memory_usage.threshold = -1;
        memory_usage.symbol = " ";
        memory_usage.format = ''
          ''${ram} ''${ram_pct}
        '';
        memory_usage.style = "bold dimmed red";
        right_format = ''
          $cmd_duration $time
        '';

      };
    };

  };
}

