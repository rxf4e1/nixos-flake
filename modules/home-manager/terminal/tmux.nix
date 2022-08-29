{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.tmux;
in {
  options = {
    modules.tmux = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      terminal = "xterm-256color";
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
  };
}
