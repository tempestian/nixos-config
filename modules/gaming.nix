{ pkgs, inputs, vars, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      protontricks
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        inhibit_screensaver = 1;
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermizer_mode = 1;
      };

      cpu = {
        park_cores = "no";
        pin_cores = "no";
      };
    };
  };

  programs.eden = {
    enable = true;
    package = inputs.eden.packages.${vars.system}.default.overrideAttrs (old: {
      preConfigure = (old.preConfigure or "") + ''
        export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error=maybe-uninitialized -Wno-maybe-uninitialized"
      '';
    });
  };

  environment.systemPackages = with pkgs; [
    heroic
    goverlay
    prismlauncher
    jdk21
  ];
}
