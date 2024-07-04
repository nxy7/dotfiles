{ ... }: {
  imports = [
    # shells
    ./nushell.nix
    ./fish.nix
    ./bash.nix
    ./elvish.nix

    # shell stuff
    ./wezterm.nix
    ./zoxide.nix
    ./helix
    ./git.nix
  ];
}
