{ config, lib, pkgs, vars, ... }:
{
  options.my.desktop.oneUiGreeter = lib.mkEnableOption "One UI giriş ekranı (kapalıyken tuigreet)";

  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };

    programs.qs-niri-system = {
      enable = true;
      profile = if config.my.desktop.oneUiGreeter then "bloated" else "base";
      greeter.user = vars.username;
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

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
      glib
      xwayland-satellite
      xdg-utils
    ];
  };
}
