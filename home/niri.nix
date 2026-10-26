{ config, lib, pkgs, vars, ... }:
let
  configFile = pkgs.writeText "niri-config.kdl" ''
    input {
        keyboard {
            numlock
            xkb {
                layout "${vars.keyboardLayout or "tr"}"
            }
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
            width 2
            active-color "#a855f7"
            inactive-color "#334155"
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

    screenshot-path "~/Resimler/Ekran Görüntüleri/Screenshot_%Y%m%d_%H%M%S.png"

    overview {
        zoom 0.75
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
        opacity 0.95
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    environment {
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORM "wayland"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_LOGGING_RULES "quickshell.dbus.properties=false"
    }

    spawn-at-startup "bash" "-c" "systemctl --user import-environment XDG_MENU_PREFIX"
    spawn-at-startup "bash" "-c" "tempest-shell start"

    binds {
        Mod+Tab repeat=false { toggle-overview; }
        Mod+Shift+E { quit; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+Shift+O { power-off-monitors; }

        // --- Tempest Shell Entegrasyonu ---
        Mod+Space repeat=false { spawn "tempest-shell" "launcher"; }
        Mod+V { spawn "tempest-shell" "clipboard"; }
        Mod+Shift+S { spawn "tempest-shell" "capture"; }
        Ctrl+Shift+S { spawn "tempest-shell" "capture"; }
        Mod+Alt+L allow-when-locked=true { spawn "tempest-shell" "lock"; }
        Mod+Comma { spawn "tempest-shell" "settings"; }
        Mod+Shift+W { spawn "tempest-shell" "preset" "next"; }
        Ctrl+Alt+T { spawn "tempest-shell" "matugen"; }

        // --- Uygulamalar ---
        Mod+T { spawn "kitty"; }
        Mod+Return { spawn "kitty"; }
        Super+E { spawn "nautilus"; }
        Super+W { spawn "firefox"; }

        // --- Pencere ve Düzen ---
        Mod+Q repeat=false allow-inhibiting=false { close-window; }
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
        Mod+Home  { focus-column-first; }
        Mod+End   { focus-column-last; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }
        Mod+Ctrl+Home   { move-column-to-first; }
        Mod+Ctrl+End    { move-column-to-last; }

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
        Mod+Shift+R { spawn "tempest-shell" "capture"; }
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

        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "set" "5%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

        XF86AudioPlay  { spawn "playerctl" "play-pause"; }
        XF86AudioPause { spawn "playerctl" "play-pause"; }
        XF86AudioNext  { spawn "playerctl" "next"; }
        XF86AudioPrev  { spawn "playerctl" "previous"; }

        Ctrl+Mod+Space { spawn "playerctl" "play-pause"; }
        Mod+Alt+N      { spawn "playerctl" "next"; }
        Mod+Alt+P      { spawn "playerctl" "previous"; }
    }
  '';

  validated = pkgs.runCommand "niri-config.kdl" { nativeBuildInputs = [ pkgs.niri ]; } ''
    cp ${configFile} $out
    HOME=$TMPDIR niri validate -c $out
  '';
in
{
  xdg.configFile."niri/config.kdl".source = validated;

  home.packages = with pkgs; [
    kitty
    wireplumber
    brightnessctl
    playerctl
    wl-clipboard
    slurp
    grim
    matugen
    bibata-cursors
  ];
}
