{ lib, pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;

  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    nautilus
    gnome-console
    gnome-calculator
    gnome-obfuscate
    gtk3
    libayatana-appindicator
  ];

  environment.variables.GI_TYPELIB_PATH =
    lib.makeSearchPath "lib/girepository-1.0" (with pkgs; [
      gtk3
      libayatana-appindicator
    ]);

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.dconf.enable = true;
}
