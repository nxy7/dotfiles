{ pkgs, ... }: {
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # environment.etc = {
  #   "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
  #     context.properties = {
  #       default.clock.rate = 48000
  #       default.clock.quantum = 32
  #       default.clock.min-quantum = 32
  #       default.clock.max-quantum = 32
  #     }
  #   '';
  # };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
}
