{ ... }: {
  imports = [
    # shells
    ./nushell.nix
    ./bash.nix

    # shell stuff
    # ./wezterm.nix
    ./zoxide.nix
    ./helix
    ./git.nix
  ];
}
