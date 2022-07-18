{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    # user = "rxf4el";
    # dataDir = "$HOME/Syncthing";
    # configDir = "$HOME/.config/Syncthing";
  };
}
