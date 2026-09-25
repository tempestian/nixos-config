{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix        
      ./network.nix      
      ./desktop.nix
      ./gaming.nix  
    ];

  system.stateVersion = "26.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap = { enable = true; memoryPercent = 50; };

  time.timeZone = "Europe/Istanbul";
  time.hardwareClockInLocalTime = false;
  services.timesyncd.enable = true;
  networking.timeServers = [ "time.cloudflare.com" "pool.ntp.org" ];

  i18n.defaultLocale = "tr_TR.UTF-8";
 
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };
 
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
 
  console.keyMap = "trq";
 
  users.users.bayram = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    imagemagick
    pciutils
    lshw
    gparted
    gtk3
    libayatana-appindicator
  ];

  environment.variables.GI_TYPELIB_PATH =
  lib.makeSearchPath "lib/girepository-1.0" (with pkgs; [
    gtk3
    libayatana-appindicator
  ]);

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.max-jobs = 6;
}
