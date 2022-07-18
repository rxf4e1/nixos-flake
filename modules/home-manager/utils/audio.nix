{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
      pavucontrol
      pulsemixer
    ];
  }
