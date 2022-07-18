{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e644eb8d-7623-45da-b0ed-0fe80ae47b39";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/e644eb8d-7623-45da-b0ed-0fe80ae47b39";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/e644eb8d-7623-45da-b0ed-0fe80ae47b39";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/e644eb8d-7623-45da-b0ed-0fe80ae47b39";
      fsType = "btrfs";
      options = [ "subvol=@var" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/e644eb8d-7623-45da-b0ed-0fe80ae47b39";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ADB5-BD14";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0f98247b-4cc8-466a-9bed-10a087521748"; }
    ];
  
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
  }; # <<-- End zramSwap Section
  
  powerManagement.cpuFreqGovernor = "powersave";
  
}
