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
    git.enable = true;
    kakoune.enable = true;
    media.enable = true;
  };
}
