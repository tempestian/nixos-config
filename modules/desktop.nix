{ config, lib, pkgs, vars, ... }:
let
  palette = import ../home/theme/palette.nix { inherit lib pkgs; };
in
{
  options.my.desktop.tempestLoginManager = lib.mkEnableOption "Tempest Login Manager (greetd + cage)";

  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };

    programs.tempest-shell = {
      enable = true;
      tempest-login-manager = config.my.desktop.tempestLoginManager;
      command = "niri-session";
      user = vars.username;
      wallpaper = palette.wallpaper;
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.login.enableGnomeKeyring = true;

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
