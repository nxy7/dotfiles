{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    fuse3
    icu
    zlib
    nss
    openssl
    # curl
    expat
  ];
}
