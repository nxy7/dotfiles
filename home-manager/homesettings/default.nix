{ username, pkgs, inputs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
    };
  };
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.home-manager.enable = true;
}

