{ config, lib, pkgs, ... }:
with lib;
let
	cfg = config.modules.kitty;
in {
  options = {
    modules.kitty= {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      font = {
        size = mkOption {
          type = types.int;
          default = 10;
        };
        name = mkOption {
          type = types.str;
          default = "monospace";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      theme = "Tomorrow Night";
      environment = {};
      font = {
        name = cfg.font.name;
        size = cfg.font.size;
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+shift+q" = "noop";
      };
      settings = {
        scrollback_lines = 2000;
        enable_audio_bell = false;
        update_check_interval = 0;

        mouse_hide_wait = -1;
        copy_on_select = true;

        repaint_delay = 10;
        input_delay = 1;
        sync_to_monitor = true;
      };
      extraConfig = ''
        
      '';
    };
    
    # home.packages = with pkgs; [ kitty ];
  };
}

