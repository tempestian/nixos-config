{ vars, ... }:
{
  imports = [
    ./packages.nix
    ./fastfetch.nix
    ./shell.nix
    ./terminal.nix
    ./git.nix
    ./flatpak.nix
    ./gaming.nix
    ./niri.nix
    ./quickshell.nix
    ./mime.nix
    ./theme
    ./ai.nix
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = vars.stateVersion;

  programs.home-manager.enable = true;
}
