{ config, lib, ... }:
{
  options.my.cpu.disableBoost = lib.mkEnableOption "CPU boost'u kapat (cpufreq/boost = 0)";

  config = lib.mkIf config.my.cpu.disableBoost {
    systemd.tmpfiles.rules = [
      "w /sys/devices/system/cpu/cpufreq/boost - - - - 0"
    ];
  };
}
