{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    user = "rxf4el";
    dataDir = "$HOME/Documents/Syncthing";
    # configDir = "$HOME/.config/Syncthing";
  };
}
