{ pkgs, ... }: {
  users.groups.embeddev = { };

  # programs.fish.enable = true;
  # programs.xonsh.enable = true;
  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    shell = pkgs.nushell;
  };

  services.displayManager.autoLogin = {
    user = "nxyt";
    enable = true;
  };
}
