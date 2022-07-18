{ config, pkgs, inputs, ... }:

{
  # imports = [
  #   ./pkgs/macspoof.nix
  # ];


  # Use the systemd-boot EFI boot loader.
  boot = { 
    supportedFilesystems = [ "btrfs" ];
    loader = {
      # systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };
    
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
      supportedFilesystems = [ "btrfs" ];
      luks.devices = {
        crypted = {
          device = "/dev/disk/by-partuuid/7074f946-6034-406b-b6e7-8186214ee3aa";
	        allowDiscards = true;
	        preLVM = true;
        };
      };
    }; # <<-- End Initrd
    
    blacklistedKernelModules = [
      "kvm_intel"
      "nvidia"
      "nouveau"
      "radeon"
    ];
    
    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "msr"
      "zram"
    ];
    
    kernelParams = [
      "nohibernate"
      "ipv6.disable=0"
      "acpi_backlight=native"
      "msr.allow_writes=on"
    ];
    
    kernel.sysctl = {
      "vm.swappiness"=10;
      "vm.vfs_cache_pressure"=50;
      "vm.dirty_background_ratio"=1;
    };
    
    extraModulePackages = [ ];
    
    tmpOnTmpfs = false;
    cleanTmpDir = true;
    
  }; # <<-- End Boot Section

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      # keep-outputs = true
      # keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    settings = {
      # Caching
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
      allowed-users = [ "@wheel" "rxf4el" ];
      trusted-users = [ "@wheel" "rxf4el" ];
      sandbox = true;
      max-jobs = 8;
    };
  }; # <<-- End Nix Section

  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ inputs.emacs-overlay.overlay ];
  }; # <<-- End Nixpkgs Section

  networking = {
    hostId = "d34db33f";
    hostName = "aspire-a315";  # Define your hostname.
    wireless = {
      enable = true;  # Enables wireless support via wpa_supplicant.
      networks = {
	      obscurus = {
	        priority = 1;
	        authProtocols = [ "WPA-PSK" ];
	        # psk = "";
	        pskRaw = "9f158db5874de90a985a802a62197624eed01ac791d7c91181c8d3fd6e7fd2ab";
	      };
      };
    };
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall = {
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
    
  }; # <<-- End networking Section

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  
  environment = {
    systemPackages = with pkgs; [
      (aspellWithDicts (ps: with ps; [en pt_BR]))
      curl gitFull wget
      cacert cargo nanorc zsh
      binutils coreutils dnsutils
      inetutils pciutils usbutils
      acpi lm_sensors pstree
      gnupg gnumake
      rlwrap autoconf cmake ctags 
      gcc guile perl
      unzip zip zlib.dev
      vulkan-headers vulkan-loader vulkan-tools
      cachix patchelf 
      nix-prefetch-git nix-index
      nixpkgs-fmt nix-tree rnix-lsp
    ];
    variables = {
      # Force AMDVLK - (opensource)
      # AMD_VULKAN_ICD = "AMDVLK";
      # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
      
      # Force RADV - (proprietary)
      AMD_VULKAN_ICD = "RADV";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/amd";
    };

  }; # <<-- End environment Section

  fonts = {
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "RobotoMono"
        ];
      })
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      fira-code-symbols
      liberation_ttf
      terminus_font
    ];
  }; # <<-- End fonts Section

  sound.enable = true;
  
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      setLdLibraryPath = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        # amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [
        # driversi686Linux.amdvlk
        libva
        libvdpau-va-gl
        vaapiVdpau
      ];
    };
    bluetooth.enable = true;
    openrazer.enable = true;
  }; # <<-- End hardware Section

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  }; # <<-- End XDG Section

  services = {
    acpid.enable = true;
    blueman.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };

    # flatpak = {
    #   enable = true;
    # };

    openssh = {
      enable = true;
      permitRootLogin = "no";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      socketActivation = true;
    };

    tlp.enable = true;

    printing.enable = false;

    journald.extraConfig = "SystemMaxUse=256M";

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      videoDrivers = [ "amdgpu" ];
      # deviceSection = ''
      #   Option ""
      #   Option "" ""
      # '';
      # useGlamor = true;
      layout = "br";
      xkbVariant = "abnt2";
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "adaptive";
          accelSpeed = "-0.5";
          disableWhileTyping = true;
          naturalScrolling = false;
        };
        touchpad = {
          accelProfile = "adaptive";
          clickMethod = "buttonareas";
          disableWhileTyping = true;
          naturalScrolling = true;
          scrollMethod = "twofinger";
          tapping = false;
        };
      };
    };

  }; # <<-- End services Section
  
  programs = {
    adb.enable = true;
    dconf.enable = true;
    gnupg.agent.enable = true;
    mtr.enable = true;

    zsh = {
      enable = true;
      interactiveShellInit = ''
        source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
        zstyle ':prompt:grml:left:items:user' pre '%F{green}%B'
      '';
      promptInit = "";
    };
    
  }; # <<-- End programs Section

  users = {
    users.rxf4el = {
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
      # openssh.authorizedKeys.keys = [ ];
    }; # <<-- End rxf4el Section
  }; 

  system = {
    # autoUpgrade.channel = https://nixos.org/channels/nixos-22.05;
    stateVersion = "22.11"; # Did you read the comment?
  };
  
}
