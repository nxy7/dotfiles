pkgs:
let
  poshConfig = builtins.toFile "posh-config.json"
    (builtins.readFile ../oh-my-posh/posh-config.json);
in {
  enable = true;
  package = pkgs.nushellFull;
  extraConfig = ''
    alias z = zoxide

    alias rm = ^rm -r
    alias cp = ^cp -r
    alias la = ls -a
    alias ll = ls -l
    alias kctl = sudo k3s kubectl
    alias home-switch = nix run . switch -- --flake . --impure 
    alias system-switch = sudo nixos-rebuild --flake . --impure
    alias lg = lazygit
    alias k = kubectl
    alias grep = rg -S



    source ~/.zoxide.nu
    # use ~/.cache/starship/init.nu
    # source ~/.oh-my-posh.nu



    ${pkgs.freshfetch}/bin/freshfetch
  '';
  extraEnv = ''
    $env.PATH = ($env.PATH | split row ":" | prepend $"($env.HOME)/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin");

    $env.config = {
      show_banner: false,
    };
    $env.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

    ${pkgs.zoxide}/bin/zoxide init nushell | save -f ~/.zoxide.nu;
    # ${pkgs.oh-my-posh}/bin/oh-my-posh init nu -c ${poshConfig};
  '';
}
