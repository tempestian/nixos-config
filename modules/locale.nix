{ lib, vars, ... }:
{
  time.timeZone = vars.timeZone;
  time.hardwareClockInLocalTime = false;
  services.timesyncd.enable = true;
  networking.timeServers = [ "time.cloudflare.com" "pool.ntp.org" ];

  i18n.defaultLocale = vars.locale;
  i18n.extraLocaleSettings = lib.genAttrs [
    "LC_ADDRESS"
    "LC_IDENTIFICATION"
    "LC_MEASUREMENT"
    "LC_MONETARY"
    "LC_NAME"
    "LC_NUMERIC"
    "LC_PAPER"
    "LC_TELEPHONE"
    "LC_TIME"
  ] (_: vars.locale);

  services.xserver.xkb = {
    layout = vars.keyboardLayout;
    variant = "";
  };

  console.keyMap = "trq";
}
