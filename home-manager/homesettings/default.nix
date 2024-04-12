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
    };
  };

  programs.home-manager.enable = true;

  systemd.user.services = {
    obsidian = {
      Unit = { Description = "Start Obsidian"; };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.obsidian}/bin/obsidian";
        Wants = "network-online.target";
        After = "network-online.target";
      };

      Install = { WantedBy = [ "default.target" ]; };

    };
  };

  systemd.user.timers = {
    obsidian = {
      Unit = { Description = "Start every day of the week"; };

      Timer = {
        "OnBootSec" = "1sec";
        "OnCalendar" = "Sat..Sun *-*-* 00:00:00";
        "Persistent" = "true";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}

