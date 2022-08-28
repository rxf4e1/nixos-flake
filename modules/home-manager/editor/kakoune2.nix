{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.kakoune;
in {
  options = {
    modules.kakoune = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Kakoune Editor.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.kakoune = {
      enable = true;
    };
	};
}
