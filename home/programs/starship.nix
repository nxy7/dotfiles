{
  enable = true;
  settings = {
    time.disabled = false;

    memory_usage.disabled = false;
    memory_usage.threshold = -1;
    memory_usage.symbol = " ";
    memory_usage.format = ''
      ''${ram} ''${ram_pct}
    '';
    memory_usage.style = "bold dimmed red";
    right_format = ''
      $memory_usage $time
    '';
  };
}
