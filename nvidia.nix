{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
  environment.sessionVariables = { NVD_BACKEND = "direct"; MOZ_DISABLE_RDD_SANDBOX = "1"; };

  services.fstrim.enable = true;

  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpufreq/boost - - - - 0"
  ];

}
