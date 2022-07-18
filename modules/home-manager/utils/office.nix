{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # libreoffice-bin
    # onlyoffice-bin
    pcmanfm
    poppler
    zathura
  ];
}
