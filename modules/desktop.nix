{ config, lib, pkgs, vars, ... }:
{
  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd niri-session";
          user = "greeter";
        };
      };
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
