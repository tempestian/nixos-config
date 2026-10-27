{ vars, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./terminal.nix
    ./git.nix
    ./flatpak.nix
    ./gaming.nix
    ./display.nix
    ./niri.nix
    ./quickshell.nix
    ./mime.nix
    ./theme
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = vars.stateVersion;

  programs.home-manager.enable = true;
}
