{ username, pkgs, inputs, config, ... }: {
  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
    };
  };

  programs.home-manager.enable = true;
}

