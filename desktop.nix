{ config, pkgs, lib, ... }:
{
  programs.inir.desktop.displayManager = "greetd";

  environment.systemPackages = with pkgs; [
    nautilus
  ];
}
