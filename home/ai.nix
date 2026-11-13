{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lmstudio
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
