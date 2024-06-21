{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Dawid Danieluk";
    userEmail = "danielukd@gmail.com";
    extraConfig = { credential = { helper = "cache"; }; };
  };
  programs.lazygit = {
    enable = true;
    settings.git.commit.signOff = false;
    settings.os.editPreset = "helix";
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
