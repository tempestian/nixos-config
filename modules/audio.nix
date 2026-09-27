{ config, pkgs, lib, ... }:
let
  cfg = config.programs.inir.audio;
in
{
  options.programs.inir.audio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable PipeWire audio stack required for iNiR volume and media player widgets.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = lib.mkDefault false;
    security.rtkit.enable = lib.mkDefault true;
    services.pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
    };

    environment.systemPackages = [ pkgs.pulseaudio ];
  };
}
