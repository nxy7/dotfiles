{
  enable = true;
  extraConfig = ''
    alias z = zoxide;
    source ~/.zoxide.nu;
  '';
  extraEnv = ''
    zoxide init nushell | save -f ~/.zoxide.nu;
  '';
}
