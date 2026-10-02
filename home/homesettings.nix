{
  pkgs,
  lib,
  isLinux ? pkgs.stdenv.isLinux,
  isDarwin ? pkgs.stdenv.isDarwin,
  ...
}:
{
  home = {
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.npm-global/bin" ];

    # EDITOR comes from programs.helix.defaultEditor (home/helix.nix).
    # LD_LIBRARY_PATH and MESA_VK_DEVICE_SELECT are set system-wide on NixOS
    # (system/environment.nix).
    sessionVariables = lib.optionalAttrs isLinux {
      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compabilitytools.d";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    file.".face".source = ../avatar.jpg;
  };

  programs.home-manager.enable = true;

  # The system-level GC (root) only expires system generations; each
  # home-manager switch pins another closure in this user's profile.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
