{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      rm = "rm -r";
      mv = "mv -r";
      z = "zellij";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      cp = "cp -rfL";
    };
    bashrcExtra = ''
      echo "set show-all-if-ambiguous on
      set completion-ignore-case on" > $HOME/.inputrc;
    '';
    profileExtra = ''
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
