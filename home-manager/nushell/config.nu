$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

#~/.config/nushell/config.nu
source ~/.cache/carapace/init.nu

alias z = zoxide

alias vi = nvim
alias rm = ^rm -r
alias cp = ^cp -r
alias l = ls
alias la = ls -a
alias ll = ls -l
alias kctl = sudo k3s kubectl
alias lg = lazygit
alias k = kubectl
alias grep = rg -S
alias just = just --unstable

def gotoDotfiles [] {
  cd ~/dotfiles
}

alias nfs = nix-full-system-update
# full system update (system + home manager)
def nix-full-system-update [
  --update (-u)
] {
  gotoDotfiles;
  if $update {
    nix flake update
  }
  nss;
  nhs;
}

alias nhs = nix-home-manager-update
# home manager update
def nix-home-manager-update [] {
  gotoDotfiles
  home-manager switch --flake . --impure; 
  spd-say 'Home configuration updated';
}

alias nss = nix-system-update
# system update
def nix-system-update [] {
  gotoDotfiles
  sudo nixos-rebuild switch --flake . --impure;
  spd-say 'System updated';
}


def vpn-restart [] {
  sudo ipsec down fsh;
  sudo ipsec up fsh;
  spd-say 'Connected to VPN'
}

def argo-get-pw [] {
   kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d | wl-copy 
  print "fsh password copied to clipboard"
}

def fsh-get-pw [] {
  cd ~/dotfiles
  open s | from yaml | get Password | wl-copy
  print "fsh password copied to clipboard"
}

source ~/.zoxide.nu
# use ~/.cache/starship/init.nu


freshfetch
