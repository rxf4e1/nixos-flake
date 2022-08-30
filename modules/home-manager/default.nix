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
    alacritty = {
      enable = false;
      font.size = 8;
      font.name = "MesloLGS NF";
    };
    audio.enable = true;
    browsers.enable = true;
    clitools.enable = true;
    emacs.enable = true;
    fonts.enable = true;
    git.enable = true;
    gtk.enable = true;
    kakoune.enable = true;
    kitty.enable = true;
    media.enable = true;
    notify.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };
}
