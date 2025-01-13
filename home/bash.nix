{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = "\n\n";
  };
}
