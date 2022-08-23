{ config, lib, pkgs, ... }:
with lib;
let

  cfg = config.local.users;

in {

  options.local.users = {
    mainUser = mkOption {
      type = types.str;
      default = "rxf4el";
      description = "Default system username.";
    };
  };

  config = {
    users.users.${cfg.mainUser} = {
      isNormalUser = true;
      createHome = true;
      home = "/home/rxf4el";
      uid = 1000;
      group = "users";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "input"
        "disk"
        "kvm"
        "adbusers"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };
}
