{ config, pkgs, ... }:
let

  dbus-openbox-environment = pkgs.writeTextFile {
    name = "dbus-openbox-environment";
    destination = "/bin/dbus-openbox-environment";
    executable = true;
    text =
      ''
      dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP=openbox
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal
      '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Matcha-dark-sea'
      gsettings set $gnome_schema icon-theme 'Papirus-Dark-Maia'
      gsettings set $gnome_schema cursor-theme 'Bibata_Ghost'
      gsettings set $gnome_schema font-name 'Terminus 10'
    '';
  };

in {

  services.xserver.windowManager.openbox.enable = true;
  
  environment.systemPackages = with pkgs; [
    dbus-openbox-environment
    configure-gtk
    autorandr
    bemenu
    brightnessctl
    dmenu
    obconf
    jq
    scrot
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
