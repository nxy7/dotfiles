{
  enable = true;
  autocd = true;
  # dotDir = ".config/zsh";
  enableCompletion = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
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
  initExtra = ''
    source $HOME/.nix-profile/etc/profile.d/nix.sh;
    exec nu;
  '';
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "golang" "tmux" "rust" "gh" ];
    theme = "afowler";
  };
}
