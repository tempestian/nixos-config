{ config, lib, pkgs, inputs, vars, ... }:
let
  palette = import ./theme/palette.nix { inherit lib pkgs; };
  qs = inputs.qs-niri.packages.${vars.system}.default;
  awwwBin = "${pkgs.awww}/bin/awww";

  wallpaperInit = pkgs.writeShellScript "wallpaper-init" ''
    state="$HOME/.cache/qs-wallpaper-last.json"
    if [ -f "$state" ]; then
      exec ${qs}/scripts/restore-wallpaper.sh
    fi
    for _ in $(seq 1 25); do
      ${awwwBin} query >/dev/null 2>&1 && break
      sleep 0.2
    done
    exec ${awwwBin} img ${palette.wallpaper} --transition-type none
  '';

  colorsFile = "${config.home.homeDirectory}/.config/niri/colors.kdl";
  keyboardFile = "${config.home.homeDirectory}/.config/niri/qs-keyboard.kdl";

  touch = name: ''spawn-sh "touch /tmp/qs-${name}";'';

  ocrTesseract = pkgs.tesseract.override { enableLanguages = [ "eng" "tur" ]; };

  ocrScript = pkgs.writeShellScript "region-ocr" ''
    geometry=$(${pkgs.slurp}/bin/slurp) || exit 0
    text=$(${pkgs.grim}/bin/grim -g "$geometry" - | ${ocrTesseract}/bin/tesseract stdin stdout -l eng+tur 2>/dev/null)
    printf '%s' "$text" | ${pkgs.wl-clipboard}/bin/wl-copy
    ${pkgs.libnotify}/bin/notify-send "OCR" "$text"
  '';

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
        gaps 12
        center-focused-column "never"
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }
        focus-ring {
            width 3
        }
        border {
            off
        }
        shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
        struts {
        }
    }

    prefer-no-csd

    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    blur {
        passes 4
        offset 4
    }

    spawn-at-startup "awww-daemon"
    spawn-at-startup "${wallpaperInit}"
    spawn-at-startup "soteria"

    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    window-rule {
        match app-id=r#"^kitty$"#
        background-effect {
            blur true
        }
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    binds {
        Mod+Slash hotkey-overlay-title="Kısayol listesi" { show-hotkey-overlay; }
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+Return hotkey-overlay-title="Terminal: kitty" { spawn "kitty"; }
        Mod+T { spawn "kitty"; }
        Mod+E hotkey-overlay-title="Dosya yöneticisi" { ${touch "files"} }
        Mod+W hotkey-overlay-title="Tarayıcı: firefox" { spawn "firefox"; }
        Mod+B { spawn "firefox"; }

        Mod+Space repeat=false hotkey-overlay-title="Arama / uygulama başlatıcı" { ${touch "launcher"} }
        Mod+Tab repeat=false hotkey-overlay-title="Genel bakış" { toggle-overview; }
        Mod+O repeat=false { toggle-overview; }
        Mod+V hotkey-overlay-title="Pano geçmişi" { ${touch "clipboard"} }
        Mod+Semicolon hotkey-overlay-title="Emoji" { ${touch "emoji"} }
        Mod+Alt+A hotkey-overlay-title="Denetim merkezi" { ${touch "controlcenter"} }
        Mod+N hotkey-overlay-title="Bildirimler" { ${touch "sidebar"} }
        Mod+Shift+D hotkey-overlay-title="Gösterge paneli" { ${touch "dashboard"} }
        Mod+Alt+M hotkey-overlay-title="Medya paneli" { ${touch "media"} }
        Mod+Alt+S hotkey-overlay-title="Sistem araçları" { ${touch "systools"} }
        Mod+Alt+T hotkey-overlay-title="Hız testi" { ${touch "speedtest"} }
        Mod+Alt+H hotkey-overlay-title="Hotspot QR" { ${touch "hotspotqr"} }
        Ctrl+Shift+Escape hotkey-overlay-title="Görev yöneticisi" { ${touch "taskmanager"} }

        Mod+Shift+Q hotkey-overlay-title="Güç menüsü" { ${touch "powermenu"} }
        Mod+Alt+Q { ${touch "powermenu"} }
        Mod+Alt+L allow-when-locked=true hotkey-overlay-title="Ekranı kilitle" { ${touch "lock"} }
        Super+Alt+L allow-when-locked=true { ${touch "lock"} }

        Mod+Shift+S hotkey-overlay-title="Bölge ekran görüntüsü" { screenshot; }
        Ctrl+Shift+S { screenshot; }
        Mod+Shift+X hotkey-overlay-title="Bölgeden metin kopyala (OCR)" { spawn "${ocrScript}"; }
        Mod+Shift+R hotkey-overlay-title="Ekran kaydı" { ${touch "record"} }
        Mod+Alt+R { ${touch "record"} }
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Mod+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioPause       allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }
        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+5%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "5%-"; }

        Ctrl+Mod+Space hotkey-overlay-title="Oynat / duraklat" { spawn-sh "playerctl play-pause"; }
        Mod+Shift+P { spawn-sh "playerctl play-pause"; }
        Mod+Alt+N hotkey-overlay-title="Sonraki parça" { spawn-sh "playerctl next"; }
        Mod+Shift+N { spawn-sh "playerctl next"; }
        Mod+Alt+P hotkey-overlay-title="Önceki parça" { spawn-sh "playerctl previous"; }
        Mod+Shift+B { spawn-sh "playerctl previous"; }
        Mod+Shift+M hotkey-overlay-title="Sesi kapat / aç" { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }

        Mod+Q repeat=false allow-inhibiting=false hotkey-overlay-title="Pencereyi kapat" { close-window; }

        Mod+D hotkey-overlay-title="Sütunu tam boy yap / geri al" { maximize-column; }
        Mod+F hotkey-overlay-title="Tam ekran / normal" { fullscreen-window; }
        Mod+Shift+F { fullscreen-window; }
        Mod+M hotkey-overlay-title="Pencereyi kenarlara kadar büyüt" { maximize-window-to-edges; }
        Mod+A hotkey-overlay-title="Yüzen / döşeli geçişi" { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+Shift+Space { switch-focus-between-floating-and-tiling; }
        Mod+Shift+W hotkey-overlay-title="Sekmeli görünüm" { toggle-column-tabbed-display; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }
        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Ctrl+Left  { focus-monitor-left; }
        Mod+Ctrl+Down  { focus-monitor-down; }
        Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Right { focus-monitor-right; }
        Mod+Ctrl+Shift+Left  { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+Down  { move-column-to-monitor-down; }
        Mod+Ctrl+Shift+Up    { move-column-to-monitor-up; }
        Mod+Ctrl+Shift+Right { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }
        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

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

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
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

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
        Mod+Shift+O { power-off-monitors; }
    }

    include "${colorsFile}"
    include "${keyboardFile}"
  '';

  validated = pkgs.runCommand "niri-config.kdl" { nativeBuildInputs = [ pkgs.niri ]; } ''
    cp ${configFile} $out
    echo 'layout { focus-ring { active-color "#89b4fa"; inactive-color "#45475a"; }; }' > colors.kdl
    echo 'input { keyboard { xkb { layout "${vars.keyboardLayout}"; }; }; }' > qs-keyboard.kdl
    sed -e "s|${colorsFile}|$PWD/colors.kdl|" -e "s|${keyboardFile}|$PWD/qs-keyboard.kdl|" $out > check.kdl
    HOME=$TMPDIR niri validate -c check.kdl
  '';
in
{
  xdg.configFile."niri/config.kdl".source = validated;

  # qs-niri bu dosyayı Ayarlar > Shell > Keyboard üzerinden yazar; yoksa niri config'i yüklenemez
  home.activation.niriKeyboardKdl = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    f="${keyboardFile}"
    if [ ! -e "$f" ]; then
      mkdir -p "$(dirname "$f")"
      printf 'input {\n    keyboard {\n        xkb {\n            layout "%s"\n        }\n    }\n}\n' "${vars.keyboardLayout}" > "$f"
    fi
  '';

  home.packages = with pkgs; [
    awww
    mpvpaper
    soteria
    python3
    ffmpeg
    imagemagick
    speedtest-cli
    pulseaudio
    wireplumber
    brightnessctl
    playerctl
  ];
}
