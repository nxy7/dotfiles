{ username, pkgs, inputs, config, ... }: {
  home = rec {

    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";

      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compabilitytools.d";

    };
    sessionPath = [ "${./../scripts}" ];

    file.".face".source = ../avatar.jpg;
  };
  programs.home-manager.enable = true;
}

