{ config, pkgs, ... }:

let 

  spoof-mac = pkgs.writeShellScript "spoof-mac" ''
    card=$1
    tmp=$(mktemp)
    ${pkgs.macchanger}/bin/macchanger "$card" -s | grep -oP "[a-zA-Z0-9]{2}:[a-zA-Z0-9]{2}:[^\ ]*" > "$tmp"
    mac1=$(cat "$tmp" | head -n 1)
    mac2=$(cat "$tmp" | tail -n 1)
    if [ "$mac1" = "$mac2" ]; then
      if [ "$(cat /sys/class/net/"$card"/operstate)" = "up" ]; then
        ${pkgs.iproute2}/bin/ip link set "$card" down &&
        ${pkgs.macchanger}/bin/macchanger -r "$card"
        ${pkgs.iproute2}/bin/ip link set "$card" up
      else
        ${pkgs.macchanger}/bin macchanger -r "$card"
      fi
    fi
  '';

in {

  environment.systemPackages = with pkgs; [
    iproute2
    macchanger
  ];

  systemd.services.macchanger = {
    enable = true;
    description = "MAC Changer on WiFi card.";
    wants = [ "network-pre.target" ];
    before = [ "network-pre.target" ];
    bindsTo = [ "sys-subsystem-net-devices-wlp3s0.device" ];
    after = [ "sys-subsystem-net-devices-wlp3s0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${spoof-mac} wlp3s0";
    };
  };

}
