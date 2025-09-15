{
  inputs,
  pkgs,
  lib,
  config,
  isLinux ? pkgs.stdenv.isLinux,
  ...
}:
let
  isMacos = !isLinux;
in
{
  imports = [ ] ++ lib.optionals isLinux [ inputs.zen-browser.homeModules.default ];

  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    fzf.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

  }
  // lib.optionalAttrs isMacos {
  }
  // lib.optionalAttrs isLinux {
    zen-browser = {
      enable = true;
      # nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };

    bash.enable = true;

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
