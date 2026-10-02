#!/usr/bin/env bash
# Fresh NixOS install: clone the repo, switch the system, then home-manager.
# Flakes aren't enabled on a fresh install yet; the system config enables them.
set -euo pipefail

export NIX_CONFIG="experimental-features = nix-command flakes"

nix shell nixpkgs#git --command git clone https://github.com/nxy7/dotfiles.git
cd dotfiles

# --impure: the system config imports /etc/nixos/hardware-configuration.nix.
sudo --preserve-env=NIX_CONFIG nixos-rebuild switch --flake .#nixos --impure
home-manager switch --flake .#nxyt
