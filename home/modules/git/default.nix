{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "nxy7";
    userEmail = "lolnoxy@gmail.com";
    extraConfig = { credential = { helper = "cache"; }; };
  };
  programs.lazygit = {
    enable = true;
    settings.git.commit.signOff = true;
    settings.os.editPreset = "helix";
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
