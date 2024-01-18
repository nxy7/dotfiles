{ pkgs, ... }: {
  programs.broot = {
    enable = true;

    enableNushellIntegration = true;

  };
}
