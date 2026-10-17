{ vars, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../modules
  ];

  system.stateVersion = vars.stateVersion;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  my.network.ttlFix.enable = true;
  my.network.zapret.enable = true;
  my.cpu.disableBoost = true;
  my.desktop.oneUiGreeter = true;
}
