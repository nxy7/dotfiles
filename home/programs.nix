{ inputs, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.default ];

  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    fzf.enable = true;
    k9s.enable = true;
    fish.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };

    satty = {
      enable = true;
    };

    bash = {
      enable = true;
      bashrcExtra = "\n\n";
    };

    zed-editor = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
    };

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
