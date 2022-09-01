{ config, lib, pkgs, ... }:

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
    emacs.enable = true;
    fonts.enable = true;
    git.enable = true;
    gtk.enable = true;
    kakoune.enable = true;
    kitty = {
      enable = true;
      font.name = "Terminus";
      font.size = 9;
    };
    media.enable = true;
    notify.enable = true;
    office.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };
}
