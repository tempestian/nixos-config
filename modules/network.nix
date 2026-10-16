{ config, lib, vars, ... }:
let
  cfg = config.my.network;
in
{
  options.my.network = {
    ttlFix = {
      enable = lib.mkEnableOption "TTL override (tethering için)";
      ttl = lib.mkOption {
        type = lib.types.ints.between 1 255;
        default = 65;
        description = "Giden paketlere uygulanacak TTL değeri.";
      };
    };
    zapret.enable = lib.mkEnableOption "zapret DPI bypass";
  };

  config = lib.mkMerge [
    {
      networking.hostName = vars.hostName;
      networking.networkmanager = {
        enable = true;
        dns = "none";
      };
      networking.nameservers = [ "127.0.0.1" ];
      networking.firewall.enable = true;

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
    }

    (lib.mkIf cfg.ttlFix.enable {
      boot.kernel.sysctl."net.ipv4.ip_default_ttl" = cfg.ttlFix.ttl;
      boot.kernelModules = [ "iptable_mangle" ];
      networking.firewall.extraCommands = ''
        iptables -t mangle -F POSTROUTING
        iptables -t mangle -A POSTROUTING -j TTL --ttl-set ${toString cfg.ttlFix.ttl}
      '';
    })

    (lib.mkIf cfg.zapret.enable {
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
    })
  ];
}
