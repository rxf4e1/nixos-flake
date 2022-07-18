{ config, pkgs, lib, ... }:

let

  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
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
      datadir = "${schema}/share/gsettings/schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme "Matcha-dark-sea"
      gsettings set $gnome_schema icon-theme "Papirus-Dark-Maia"
      gsettings set $gnome_schema cursor-theme "capitaine-cursors"
      gsettings set $gnome_schema font-name "Terminus 10"
    '';
  };

in {
  environment.systemPackages = with pkgs; [
    dbus-hyprland-environment
    configure-gtk
    nitrogen
    brightnessctl
    wayland
    wl-clipboard
    wl-color-picker
    wlr-randr
    wdisplays
    xwayland
    swaybg
  ];

  environment.sessionVariables = rec {
    # BEMENU_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    GDK_DPI_SCALE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME="qt5ct";
    # QT_WAYLAND_FORCE_DPI = "physical";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # SDL_VIDEODRIVER = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    __GLX_VENDOR_LIBRARY_NAME = "amd";
  };

  programs.hyprland.enable = true;
}
