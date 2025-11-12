{
  username,
  pkgs,
  inputs,
  config,
  ...
}:
{
  home = rec {

    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.npm-global/bin" ];

    sessionVariables = {
      EDITOR = "hx";
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";

      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compabilitytools.d";
      MESA_VK_DEVICE_SELECT = "10de:28a0";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    file.".face".source = ../avatar.jpg;
  };
  programs.home-manager.enable = true;
}
