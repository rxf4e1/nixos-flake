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
    alacritty = {
      enable = true;
      font.size = 8;
      font.name = "MesloLGS NF";
    };
    audio.enable = true;
    browsers.enable = true;
    clitools.enable = true;
    # emacs.enable = true;
    fonts.enable = true;
    git.enable = true;
    gtk.enable = true;
    kakoune.enable = true;
    media.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };
}
