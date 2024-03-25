{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "nxy7";
    userEmail = "danielukd@gmail.com";
    extraConfig = { credential = { helper = "cache"; }; };
  };
  programs.lazygit = {
    enable = true;
    settings.git.commit.signOff = true;
    settings.os.editPreset = "hx";
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
