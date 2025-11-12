{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Dawid Danieluk";
        email = "danielukd@gmail.com";
      };

      credential = {
        helper = "cache";
      };
      pull = {
        rebase = "true";
      };

    };
  };
  programs.lazygit = {
    enable = true;
    settings = {
      git.commit.signOff = false;
      os.editPreset = "helix";
    };
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    extensions = with pkgs; [
      gh-copilot
      gh-dash
      gh-contribs
      gh-dash
    ];
  };
}
