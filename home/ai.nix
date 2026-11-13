{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lmstudio
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
