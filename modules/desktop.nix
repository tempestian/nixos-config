{ config, lib, pkgs, vars, inputs, ... }:
let
  palette = import ../home/theme/palette.nix { inherit lib pkgs; };

  patchedTempestShell = inputs.tempest-shell.packages.${vars.system}.default.overrideAttrs (old: {
    buildCommand = (old.buildCommand or "") + ''
      awk '!seen[$0]++ || !/readonly property string scannerPath/'         $out/services/Applications.qml > $out/services/Applications.qml.tmp
      mv $out/services/Applications.qml.tmp $out/services/Applications.qml
    '';
  });
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
      package = patchedTempestShell;
      tempest-login-manager = config.my.desktop.tempestLoginManager;
      command = "niri-session";
      user = vars.username;
      wallpaper = palette.wallpaper;
    };

    systemd.services.greetd.environment = {
      XDG_CACHE_HOME = "/tmp/greeter-cache";
      MESA_SHADER_CACHE_DIR = "/tmp/greeter-cache";
      __GL_ShaderDiskCachePath = "/tmp/greeter-cache";
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
