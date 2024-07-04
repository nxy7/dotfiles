{ pkgs, fullSystem, ... }: {
  programs = {
    yazi.enable = true;
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

