{ config, lib, pkgs, vars, ... }:
let
  sddmTheme = pkgs.runCommandLocal "sddm-theme-ii-pixel" { } ''
    mkdir -p $out/share/sddm/themes/ii-pixel
    cp -r ${./sddm-theme}/* $out/share/sddm/themes/ii-pixel/
  '';
in
{
  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "ii-pixel";
      extraPackages = with pkgs.kdePackages; [
        qt5compat
        qtsvg
        qtdeclarative
      ];
    };

    environment.systemPackages = with pkgs; [
      sddmTheme
      glib
      xwayland-satellite
      xdg-utils
    ];

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
  };
}
