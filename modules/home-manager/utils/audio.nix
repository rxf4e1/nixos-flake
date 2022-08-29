{ config, lib, pkgs, ... }:
with lib;
let
	cfg = config.modules.audio;
in {
  options = {
    modules.audio = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pavucontrol
      pamixer
      pulsemixer
      pulseaudio
    ];
  };
}
