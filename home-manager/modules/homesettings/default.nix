{ username, pkgs, inputs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    # fonts.fontconfig.enable = true;

    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
    };
  };
  programs.home-manager.enable = true;
}

