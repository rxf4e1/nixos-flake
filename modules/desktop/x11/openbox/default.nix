{ config, pkgs, ... }:

{

  services.xserver.windowManager.openbox.enable = true;
  
  environment.systemPackages = with pkgs; [
    autorandr
    dmenu
    obconf
    scrot
  ];
}
