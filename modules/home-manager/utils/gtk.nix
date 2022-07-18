{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    glib
    lxappearance-gtk2
    matcha-gtk-theme
    papirus-maia-icon-theme
    capitaine-cursors
    bibata-cursors-translucent
  ];

  # home.file.".gtkrc-2.0".source = ../../../config/gtkrc-2.0;
}
