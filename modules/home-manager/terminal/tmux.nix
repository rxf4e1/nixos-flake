{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    terminal = "screen-256color";
    keyMode = "emacs";
    baseIndex = 1;
    aggressiveResize = true;
    clock24 = true;
    disableConfirmationPrompt = false;
    escapeTime = 500;
    historyLimit = 1000;
    extraConfig = ''
      set -g status off
      set -g visual-activity on
      set -g mouse on
    '';
  };
}
