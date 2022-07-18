{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xclip
    xsel
    xdotool
    libpng
    xorg.libXcursor
    xorg.xcursorthemes
    xorg.xbacklight
    xorg.xfontsel
    xorg.xmodmap
    xorg.xprop
    xorg.xrandr
    xorg.xrdb
    xorg.xset
    xorg.xsetroot
  ];
}
