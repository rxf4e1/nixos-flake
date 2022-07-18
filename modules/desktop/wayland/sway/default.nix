{ config, pkgs, lib, ... }:
let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
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
  
  environment.systemPackages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    brightnessctl
    sway
    swaybg
    wayland
    xwayland
    glib
    grim
    slurp
    jq
    wl-clipboard
    wlr-randr
    wdisplays
    qt5.qtwayland
    wofi
    lxappearance-gtk2
    matcha-gtk-theme
    papirus-maia-icon-theme
    capitaine-cursors
    bibata-cursors-translucent
    pulseaudio
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland-egl;xcb
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_NONREPARENTING=1
    '';
  };
}
