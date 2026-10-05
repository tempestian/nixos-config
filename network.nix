{ config, pkgs, ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  boot.kernel.sysctl = {
    "net.ipv4.ip_default_ttl" = 65;
  };
  networking.firewall = {
    enable = true;
    extraCommands = ''
      iptables -t mangle -F POSTROUTING
      iptables -t mangle -A POSTROUTING -j TTL --ttl-set 65
    '';
  };

  boot.kernelModules = [ "iptable_mangle" ];

  networking.nameservers = [ "127.0.0.1" ];
  networking.networkmanager.dns = "none";

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      bootstrap_resolvers = [ "1.1.1.1:53" "9.9.9.9:53" ];
      ignore_system_dns = true;
    };
  };

  systemd.services.dnscrypt-proxy = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig.TimeoutStartSec = "15";
  };

  services.zapret = {
    enable = true;
    params = [
      "--filter-tcp=80"
      "--dpi-desync=multisplit"
      "--dpi-desync-split-pos=method+2"
      "--new"
      "--filter-tcp=443"
      "--dpi-desync=multisplit"
      "--dpi-desync-split-pos=2"
    ];
  };
}
