eval (starship init elvish)
eval (zoxide init elvish | slurp)
set-env CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
eval (carapace _carapace|slurp)

use readline-binding
use epm
use direnv
fn just {|@a| just --unstable @a}

fn ls {|@a| eza $@a }
fn lg {|@a| lazygit $@a }
fn ll {|@a| ls -l $@a }
fn la {|@a| ls -a $@a }
fn ll {|@a| ls -l $@a }

fn gotoDotfiles {|| cd ~/dotfiles}

fn nss {|| 
  gotoDotfiles
  sudo nixos-rebuild switch --flake . --impure;
  spd-say 'System updated';
}

fn nhs {||
  gotoDotfiles
  home-manager switch --flake . --impure; 
  spd-say 'Home configuration updated';
}

fn nfs { ||
  nss
  nhs
}

freshfetch
