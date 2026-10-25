{ config, lib, pkgs, vars, ... }:
let
  colorsFile = "${config.home.homeDirectory}/.config/niri/colors.kdl";
  keyboardFile = "${config.home.homeDirectory}/.config/niri/inir-keyboard.kdl";

  configFile = pkgs.writeText "niri-config.kdl" ''
    input {
        keyboard {
            numlock
        }
        touchpad {
            tap
            dwt
            natural-scroll
        }
        mouse {
        }
    }

    cursor {
        xcursor-theme "Bibata-Modern-Classic"
        xcursor-size 24
    }

    layout {
        gaps 16
        background-color "transparent"
        center-focused-column "never"
        always-center-single-column
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width {
            proportion 0.5
        }
        focus-ring {
            off
            width 1
        }
        border {
            off
        }
        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
    }

    prefer-no-csd

    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    overview {
        zoom 0.75
    }

    recent-windows {
        open-delay-ms 120
        debounce-ms 750
        highlight {
            active-color "#e5989bff"
            urgent-color "#ffb4abff"
            padding 18
            corner-radius 14
        }
        previews {
            max-height 520
            max-scale 0.55
        }
        binds {
            Alt+Tab { next-window; }
            Alt+Shift+Tab { previous-window; }
        }
    }

    layer-rule {
        match namespace="quickshell:iiBackdrop"
        place-within-backdrop true
        opacity 1.0
    }

    layer-rule {
        match namespace="quickshell:wBackdrop"
        place-within-backdrop true
        opacity 1.0
    }

    layer-rule {
        match namespace="^quickshell:iris-"
        background-effect {
            xray false
        }
    }

    window-rule {
        geometry-corner-radius 16
        clip-to-geometry true
    }

    window-rule {
        match app-id=r#"^(gamescope|steam_app_[0-9]+|dota2|lutris|net\.lutris\..*|heroic|com\.heroicgameslauncher\.hgl|org\.prismlauncher\.PrismLauncher|minecraft|wine|wine64)$"#
        geometry-corner-radius 0
        clip-to-geometry false
    }

    window-rule {
        match is-active=false
        opacity 0.9
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        match app-id=r#"^xembedsniproxy$"#
        open-floating true
        open-focused false
        opacity 0.0
        focus-ring { off; }
        border { off; }
        shadow { off; }
    }

    environment {
        XDG_CURRENT_DESKTOP "niri"
        XDG_MENU_PREFIX "plasma-"
        QT_QPA_PLATFORM "wayland"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_LOGGING_RULES "quickshell.dbus.properties=false"
        QT_QPA_PLATFORMTHEME "kde"
        QT_STYLE_OVERRIDE "Darkly"
    }

    spawn-at-startup "bash" "-c" "systemctl --user import-environment XDG_MENU_PREFIX"
    spawn-at-startup "bash" "-c" "wl-paste --no-newline --type text --watch ~/.config/quickshell/inir/scripts/clipboard-store.py"
    spawn-at-startup "bash" "-c" "wl-paste --type image --watch ~/.config/quickshell/inir/scripts/clipboard-image-store.sh"
    spawn-at-startup "soteria"

    binds {
        Mod+Tab repeat=false { toggle-overview; }
        Mod+Shift+E { quit; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+O { power-off-monitors; }

        Super+G { spawn "inir" "overlay" "toggle"; }
        Mod+Space repeat=false { spawn "inir" "overview" "toggle"; }
        Mod+V { spawn "inir" "clipboard" "toggle"; }
        Mod+Alt+L allow-when-locked=true { spawn "inir" "lock" "activate"; }
        Mod+Ctrl+Shift+L allow-when-locked=true { spawn "inir" "lock" "focus"; }

        Mod+Shift+S { spawn "inir" "region" "menu"; }
        Mod+Shift+X { spawn "inir" "region" "ocr"; }
        Mod+Shift+A { spawn "inir" "region" "search"; }
        Ctrl+Shift+S { spawn "inir" "region" "menu"; }

        Ctrl+Alt+T { spawn "inir" "wallpaperSelector" "toggle"; }
        Mod+Comma { spawn "inir" "settings"; }
        Mod+Slash { spawn "inir" "cheatsheet" "toggle"; }
        Mod+Shift+W { spawn "inir" "panelFamily" "cycle"; }
        Mod+Shift+Q { spawn "inir" "session" "toggle"; }
        Ctrl+Alt+F { spawn "inir" "equalizer" "toggle"; }

        Mod+T { spawn "inir" "terminal"; }
        Mod+Return { spawn "inir" "terminal"; }
        Super+E { spawn "nautilus"; }
        Super+W { spawn "inir" "browser"; }

        Mod+Q repeat=false allow-inhibiting=false { spawn "inir" "close-window"; }
        Mod+D { maximize-column; }
        Mod+F { fullscreen-window; }
        Mod+Shift+F { fullscreen-window; }
        Mod+M { maximize-window-to-edges; }
        Mod+A { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+Shift+Space { switch-focus-between-floating-and-tiling; }

        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }
        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Ctrl+Left  { focus-monitor-left; }
        Mod+Ctrl+Right { focus-monitor-right; }
        Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Down  { focus-monitor-down; }
        Mod+Ctrl+Shift+Left  { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+Right { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+Up    { move-column-to-monitor-up; }
        Mod+Ctrl+Shift+Down  { move-column-to-monitor-down; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        Mod+Page_Down { focus-workspace-down; }
        Mod+Page_Up   { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight { focus-column-right; }
        Mod+WheelScrollLeft  { focus-column-left; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { spawn "inir" "region" "recordWithSound"; }
        Mod+Alt+Shift+R { switch-preset-column-width-back; }
        Mod+Ctrl+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Print      { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Mod+Print  { screenshot-screen; }
        Alt+Print  { screenshot-window; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "inir" "audio" "volumeUp"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "inir" "audio" "volumeDown"; }
        XF86AudioMute        allow-when-locked=true { spawn "inir" "audio" "mute"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "inir" "audio" "micMute"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "inir" "brightness" "increment"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "inir" "brightness" "decrement"; }

        XF86AudioPlay  { spawn "inir" "mpris" "playPause"; }
        XF86AudioPause { spawn "inir" "mpris" "playPause"; }
        XF86AudioNext  { spawn "inir" "mpris" "next"; }
        XF86AudioPrev  { spawn "inir" "mpris" "previous"; }

        Ctrl+Mod+Space { spawn "inir" "mpris" "playPause"; }
        Mod+Alt+N      { spawn "inir" "mpris" "next"; }
        Mod+Alt+P      { spawn "inir" "mpris" "previous"; }
        Mod+Shift+M    { spawn "inir" "audio" "mute"; }
        Mod+Shift+P    { spawn "inir" "mpris" "playPause"; }
        Mod+Shift+N    { spawn "inir" "mpris" "next"; }
        Mod+Shift+B    { spawn "inir" "mpris" "previous"; }
    }

    include "${colorsFile}"
    include "${keyboardFile}"
  '';

  validated = pkgs.runCommand "niri-config.kdl" { nativeBuildInputs = [ pkgs.niri ]; } ''
    cp ${configFile} $out
    echo 'layout { focus-ring { active-color "#89b4fa"; inactive-color "#45475a"; }; }' > colors.kdl
    echo 'input { keyboard { xkb { layout "${vars.keyboardLayout}"; }; }; }' > inir-keyboard.kdl
    sed -e "s|${colorsFile}|$PWD/colors.kdl|" -e "s|${keyboardFile}|$PWD/inir-keyboard.kdl|" $out > check.kdl
    HOME=$TMPDIR niri validate -c check.kdl
  '';
in
{
  xdg.configFile."niri/config.kdl".source = validated;

  home.activation.niriKeyboardKdl = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    f="${keyboardFile}"
    if [ ! -e "$f" ]; then
      mkdir -p "$(dirname "$f")"
      printf 'input {\n    keyboard {\n        xkb {\n            layout "%s"\n        }\n    }\n}\n' "${vars.keyboardLayout}" > "$f"
    fi
  '';

  home.packages = with pkgs; [
    awww
    soteria
    python3
    ffmpeg
    imagemagick
    pulseaudio
    wireplumber
    brightnessctl
    playerctl
    nautilus
    wl-clipboard
    slurp
    grim
    jq
    matugen
  ];
}
