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
          type = types.str;
          default = "10";
        };
        name = mkOption {
          type = types.str;
          default = "monospace";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # programs.kitty = {
    #   enable = true;
    #   package = pkgs.kitty;
    #   theme = "";
    #   environment = {};
    #   font = {
    #     name = cfg.font.name;
    #     size = cfg.font.size;
    #   };
    #   keybindings = {
    #     "ctrl+c" = "copy_or_interrupt";
    #   };
    #   settings = {
    #     scrollback_lines = 2000;
    #     enable_audio_bell = false;
    #     update_check_interval = 0;
    #   };
    #   extraConfig = '''';
    # };
    home.packages = with pkgs; [ kitty ];
  };
}

