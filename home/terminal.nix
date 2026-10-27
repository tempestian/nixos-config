{ lib, pkgs, ... }:
let
  palette = import ./theme/palette.nix { inherit lib pkgs; };
  b = palette.base;
in
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    settings = {
      shell = "${pkgs.fish}/bin/fish";
      background_opacity = "0.82";
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      scrollback_lines = 10000;
      copy_on_select = "clipboard";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      remember_window_size = "no";
      initial_window_width = "100c";
      initial_window_height = "28c";

      foreground = b.text;
      background = b.bg;
      selection_foreground = b.bg;
      selection_background = palette.accentHex;
      cursor = palette.accentHex;
      color0 = b.surface;
      color1 = b.red;
      color2 = b.green;
      color3 = b.yellow;
      color4 = b.blue;
      color5 = b.pink;
      color6 = b.teal;
      color7 = b.subtext;
      color8 = b.overlay;
      color9 = b.red;
      color10 = b.green;
      color11 = b.yellow;
      color12 = b.blue;
      color13 = b.pink;
      color14 = b.teal;
      color15 = b.text;
    };

    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
    };

    extraConfig = ''
      include matugen-colors.conf
    '';
  };
}
