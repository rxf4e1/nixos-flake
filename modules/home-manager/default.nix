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
    git.enable = true;
    kakoune.enable = true;
  };
}
