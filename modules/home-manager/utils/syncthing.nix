{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    user = "rxf4el";
    dataDir = "/home/rxf4el/Documents/Syncthing";
    # configDir = "$HOME/.config/Syncthing";
  };
}
