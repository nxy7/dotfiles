{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    zlib
    nss
    openssl
    curl
    expat
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = { packages = with pkgs; [ tridactyl-native ]; };
  };
}
