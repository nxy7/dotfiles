{ pkgs, ... }: {
  services.gvfs.enable = true;
  security.polkit.enable = true;

  # service exposed on port 14564
  services.goxlr-utility = { enable = true; };

  services.syncthing = {
    enable = true;
    user = "nxyt";
    dataDir = "/home/nxyt/Sync";
    configDir = "/home/nxyt/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 4;
  };

  services.speechd.enable = true;

  services.ollama.enable = true;
  # services.speech-dispatcher.enable = true;

}
