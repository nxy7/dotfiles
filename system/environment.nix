{ pkgs, ... }:
{
  environment = {
    variables.EDITOR = "hx";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      WLR_NO_HARDWARE_CURSORS = "1";
      MESA_VK_DEVICE_SELECT = "10de:28a0";
      GPUI_DISABLE_BLINK = "1";
    };

    systemPackages = with pkgs; [
      xonsh
      qmk-udev-rules
      alacritty
    ];

    shells = with pkgs; [
      xonsh
      nushell
    ];

    etc."containers/policy.json".text = builtins.readFile ./policy.json;
  };

}
