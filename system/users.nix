{ pkgs, ... }: {
  users.groups.embeddev = { };

  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    shell = pkgs.elvish;
  };

  services.displayManager.autoLogin = {
    user = "nxyt";
    enable = true;
  };
}
