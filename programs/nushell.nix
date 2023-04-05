{
  enable = true;
  extraConfig = ''
    alias z = zoxide;
    alias lg = lazygit;
    source ~/.zoxide.nu;
    source ~/.oh-my-posh.nu;
  '';
  extraEnv = ''
    let-env PATH = ($env.PATH | split row ":" | prepend $"($env.HOME)/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin");
    zoxide init nushell | save -f ~/.zoxide.nu;
    oh-my-posh init nu;
  '';
}
