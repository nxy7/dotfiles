{ pkgs, unstablepkgs }: {
  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    packages = with pkgs; [ discord ];
    shell = unstablepkgs.nushell;
  };
}
