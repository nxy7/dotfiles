{
  enable = true;
  autocd = true;
  dotDir = ".config/zsh";
  enableCompletion = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  initExtraFirst = ''
    source $HOME/.config/aliases.sh
    source $HOME/.config/paths.sh
  '';
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "golang" "tmux" "rust" "gh" ];
    theme = "afowler";
  };
}
