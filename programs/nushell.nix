pkgs: {
  enable = true;
  extraConfig = ''
    alias z = zoxide;

    alias rm = ^rm -r;
    alias cp = ^cp -r;
    alias la = ls -a;
    alias ll = ls -l;
    alias lg = lazygit;
    source ~/.zoxide.nu;
    source ~/.oh-my-posh.nu;
    let-env config = {
      show_banner: false,
    };
  '';
  extraEnv = ''
    let-env PATH = ($env.PATH | split row ":" | prepend $"($env.HOME)/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin");
    zoxide init nushell | save -f ~/.zoxide.nu;
    oh-my-posh init nu --config ~/.config/oh-my-posh/config.json;
    let-env PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  '';
}
