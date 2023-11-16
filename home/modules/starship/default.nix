{ ... }: {
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
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
}
