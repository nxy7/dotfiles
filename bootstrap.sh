nix shell nixpkgs#git --extra-experimental-features nix-command --extra-experimental-features flakes
git clone https://github.com/nxy7/dotfiles.git
cd dotfiles
sudo nixos-rebuild switch --flake . --impure
home-manager switch --flake . --impure
