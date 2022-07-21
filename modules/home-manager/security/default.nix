{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    keepassxc
    # onionshare-gui
  ];

  # home.file.".authinfo".source = ../../../config/.authinfo.gpg;
}
