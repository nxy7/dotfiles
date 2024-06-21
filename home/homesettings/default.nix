{ username, pkgs, inputs, config, ... }: {
  home = rec {

    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      PRISMA_QUERY_ENGINE_LIBRARY =
        "${pkgs.prisma-engines}/lib/libquery_engine.node";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";

      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compabilitytools.d";
    };

    file.".face".source = ../../avatar.jpg;
  };
  programs.home-manager.enable = true;
}

