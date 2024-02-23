{ pkgs, ... }: {
  programs.fish = {

    enable = true;

    shellAbbrs = {
      "homeswitch" = "home-manager switch --flake . --impure ";
      "sysswitch" = "sudo nixos-rebuild switch --flake . --impure";
      lg = "lazygit";
      k = "kubectl";
    };
    shellAliases = {
      z = "zoxide";
      rm = "rm -r";
      cp = "cp -r";
      ls = "exa";
      la = "exa -a";
      ll = "exa -l";
      just = "just --unstable";
    };
    interactiveShellInit = ''

      function getArgoPw 
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d 
      end

      function fish_greeting
        echo sup nerd
      end

      ${pkgs.kubectl}/bin/kubectl completion fish | source

      ${pkgs.gh}/bin/gh completion -s fish | source

      ${pkgs.just}/bin/just --completions fish | source

      zoxide init fish | source

      ${pkgs.freshfetch}/bin/freshfetch
    '';
  };
  home.packages = with pkgs; [ fishPlugins.autopair-fish ];
}
