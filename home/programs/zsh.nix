pkgs: {
  enable = true;
  autocd = true;
  # dotDir = ".config/zsh";
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  enableAutosuggestions = true;
  shellAliases = {
    lg = "lazygit";
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    rm = "rm -r";
    mv = "mv";
    # z = "zoxide";
    ll = "ls -alF";
    la = "ls -A";
    kctl = "sudo k3s kubectl";
    nix-switch = "nix run . switch -- --flake .";
    l = "ls -CF";
    cp = "cp -rfL";
  };
  initExtra = ''
    # source $HOME/.nix-profile/etc/profile.d/nix.sh
    # PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
  '';
}
