{ config, lib, pkgs, vars, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs.kdePackages; [
      qt5compat
      qtsvg
      qtdeclarative
    ];
  };

  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.gpu-screen-recorder.enable = true;

  programs.dconf.enable = true;
  programs.xfconf.enable = true;

  services.gvfs.enable = true;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    nautilus
    gnome-calculator
    gnome-text-editor
    glib
    xwayland-satellite
    xdg-utils
    gtk3
    libayatana-appindicator
  ];

  environment.variables.GI_TYPELIB_PATH =
    lib.makeSearchPath "lib/girepository-1.0" (with pkgs; [
      gtk3
      libayatana-appindicator
    ]);
}
