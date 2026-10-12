{ config, pkgs, ... }:

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
    package = inputs.eden.packages.x86_64-linux.default.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [
        "-DYUZU_WARNINGS_AS_ERRORS=OFF"
        "-DCMAKE_CXX_FLAGS=-Wno-error"
      ];
    });
  };

  environment.systemPackages = with pkgs; [
    heroic
    goverlay
    prismlauncher
    jdk21
  ];
}
