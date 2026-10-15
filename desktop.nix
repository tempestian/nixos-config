{ config, pkgs, lib, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-tour
    totem
    simple-scan
    yelp
    gnome-system-monitor
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    nautilus
    gnome-console
    gnome-calculator
    gnome-obfuscate
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.dconf.enable = true;
}
