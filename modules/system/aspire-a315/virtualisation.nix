{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
    };
  };

  # Add binaries to the path
  # systemd.services.libvirtd = {
  #   path = let
  #     env = pkgs.buildEnv {
  #       name = "qemu-hook-env";
  #       paths = with pkgs; [
  #         bash libvirt kmod systemd ripgrep sd
  #       ];
  #     };
  #   in [ env ];
  #   preStart =
  #     ''
  #       mkdir -p /var/lib/libvirt/hooks
  #       mkdir -p /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin
  #       mkdir -p /var/lib/libvirt/hooks/qemu.d/win10/release/end
  #       mkdir -p /var/lib/libvirt/vgabios

  #       ln -sf /home/owner/Desktop/Sync/Files/Linux_Config/symlinks/qemu /var/lib/libvirt/hooks/qemu
  #       ln -sf /home/owner/Desktop/Sync/Files/Linux_Config/symlinks/kvm.conf /var/lib/libvirt/hooks/kvm.conf
  #       ln -sf /home/owner/Desktop/Sync/Files/Linux_Config/symlinks/start.sh /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
  #       ln -sf /home/owner/Desktop/Sync/Files/Linux_Config/symlinks/stop.sh /var/lib/libvirt/hooks/qemu.d/win10/release/end/stop.sh
  #       ln -sf /home/owner/Desktop/Sync/Files/Linux_Config/symlinks/patched.rom /var/lib/libvirt/vgabios/patched.rom

  #       chmod +x /var/lib/libvirt/hooks/qemu
  #       chmod +x /var/lib/libvirt/hooks/kvm.conf
  #       chmod +x /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
  #       chmod +x /var/lib/libvirt/hooks/qemu.d/win10/release/end/stop.sh
  #     '';
  # };

  # Enable xrdp
  # services.xrdp.enable = true; # use remote_logout and remote_unlock
  # services.xrdp.defaultWindowManager = "sway";
  # systemd.services.pcscd.enable = false;
  # systemd.sockets.pcscd.enable = false;

  environment.systemPackages = with pkgs; [
    virt-manager
    libguestfs # needed to virt-sparsify qcow2 files
  ];
}

# https://www.reddit.com/r/VFIO/comments/p4kmxr/tips_for_single_gpu_passthrough_on_nixos/
