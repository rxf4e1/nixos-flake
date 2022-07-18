{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.services.mac-spoof;
  macchanger = "${pkgs.macchanger}/bin/macchanger";
  ip = "${pkgs.iproute2}/bin/ip";
in
{
  options.services.mac-spoof = {
    enable = mkOption {
      description = "Enable/Disable Spoofing in MAC address.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) {
    ...
  };
  
}
