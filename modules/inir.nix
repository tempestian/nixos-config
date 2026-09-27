{ config, pkgs, lib, inir, ... }:

let
  inirDeps = import ./inir-deps.nix { inherit pkgs; };
  versionJsonFile = pkgs.writeText "inir-version.json" ((builtins.toJSON {
    version = inir.shortRev or "2.31.0";
    commit = inir.rev or "9574fa424c0d1008e927454e933a7fbe292f9fb2";
    installMode = "package-managed";
    updateStrategy = "package-manager";
    packageName = "inir";
    packageUpdateHint = "nixos-rebuild switch";
  }) + "\n");

  inirPatched = (pkgs.callPackage "${inir}/nix/package.nix" { inherit pkgs; }).overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./patches/inir-icon-theme.patch
      ./patches/inir-nixos-fixes.patch
    ];
  });
in
{
  imports = [
    inir.nixosModules.inir
  ];

  programs.inir = {
    enable = true;
    service.compositor = "niri";
    package = inirPatched;
    extraPackages = inirDeps;
  };

  environment.systemPackages = inirDeps;

  hardware.i2c.enable = lib.mkDefault true;

  systemd.tmpfiles.rules = [
    "L+ /bin/cat - - - - ${pkgs.coreutils}/bin/cat"
    "d /usr/share 0755 root root -"
    "L+ /usr/share/icons - - - - /run/current-system/sw/share/icons"
  ];

  programs.niri.enable = lib.mkDefault true;
  programs.dconf.enable = lib.mkDefault true;

  systemd.user.services.inir = {
    environment = {
      INIR_VENV = "%h/.local/state/quickshell/.venv";
    };
  };

  systemd.user.tmpfiles.rules = [
    "L+ %h/.local/state/quickshell/.venv - - - - %h/.local/share/inir/venv"
    "L+ %h/.local/bin/inir - - - - /run/current-system/sw/bin/inir"
    "L+ %h/.local/bin/pactl - - - - ${pkgs.pulseaudio}/bin/pactl"
    "d %h/.config/inir 0755 - - -"
    "L+ %h/.config/inir/version.json - - - - ${versionJsonFile}"
    "d %h/.config/illogical-impulse 0755 - - -"
    "L+ %h/.config/illogical-impulse/version.json - - - - ${versionJsonFile}"
    "L+ %h/.icons - - - - %h/.local/share/icons"
    "L+ %h/.config/quickshell/inir - - - - /run/current-system/sw/share/quickshell/inir"
  ];
}
