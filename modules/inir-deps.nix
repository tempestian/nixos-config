
{ pkgs }:

with pkgs; [
  git
  inotify-tools
  quickshell
  xwayland-satellite
  psmisc
  swaylock
  swayidle
  wl-clipboard
  cliphist
  libnotify
  wlsunset
  xdg-user-dirs
  xdg-utils
  xdg-desktop-portal-gtk
  xdg-desktop-portal-gnome
  gnome-keyring
  fish
  gum
  uv
  bc
  ripgrep
  jq

  kdePackages.qt5compat
  kdePackages.kirigami
  kdePackages.qtmultimedia
  kdePackages.syntax-highlighting
  kdePackages.kdialog
  kdePackages.plasma-integration
  kdePackages.plasma-browser-integration
  kdePackages.kconfig
  darkly

  awww
  matugen
  (python3.withPackages (ps: with ps; [
    pip
    materialyoucolor
    pillow
    evdev
    numpy
  ]))

  grim
  slurp
  swappy
  imagemagick
  tesseract
  wf-recorder
  ffmpeg
  pulseaudio

  brightnessctl
  ddcutil
  upower
  blueman
  networkmanagerapplet
  pavucontrol

  nerd-fonts.jetbrains-mono
  material-symbols
  papirus-icon-theme

  fuzzel
  wtype
  ydotool
  geoclue2
  fprintd
  libqalculate
  translate-shell
  socat
  mission-center
  lsp-plugins
  cava
  easyeffects
  mpv
  mpvScripts.mpris
  yt-dlp
]
