{ config, lib, pkgs, ... }:
with lib;

{
  imports = [
    ./editor
    ./git
    ./security
    ./terminal
    ./utils
  ];

  modules = {
    audio.enable = true;
    browsers.enable = true;
    clitools.enable = true;
    fonts.enable = true;
    git.enable = true;
    gtk.enable = true;
    kakoune.enable = true;
    media.enable = true;
  };
}
