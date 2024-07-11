{ pkgs, ... }: {
  users.groups.embeddev = { };

  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    shell = pkgs.nushell;
  };
}
