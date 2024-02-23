{ pkgs, ... }: {
  programs.fish.enable = true;

  users.groups.embeddev = { };

  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    packages = with pkgs; [ discord ];
    # shell = pkgs.fish;
    shell = pkgs.nushell;
  };
}
