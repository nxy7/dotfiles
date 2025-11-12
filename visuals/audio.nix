{ pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    package = pkgs.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
    # pulseaudio
    pamixer
    qpwgraph
    helvum
  ];
}
