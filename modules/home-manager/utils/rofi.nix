{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    cycle = true;
    location = "top";
    terminal = "${pkgs.foot}/bin/foot";
    theme = "themes/theme.rasi";
  };
}
