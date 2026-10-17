{ config, lib, pkgs, ... }:
let
  palette = import ./palette.nix { inherit lib pkgs; };
  home = config.home.homeDirectory;
  toml = pkgs.formats.toml { };

  c = name: "{{colors.${name}.default.hex}}";
  s = name: "{{colors.${name}.default.hex_stripped}}";

  kitty = pkgs.writeText "matugen-kitty.conf" ''
    foreground ${c "on_surface"}
    background ${c "surface"}
    selection_foreground ${c "on_primary"}
    selection_background ${c "primary"}
    cursor ${c "primary"}
    cursor_text_color ${c "on_primary"}
    url_color ${c "tertiary"}
    active_border_color ${c "primary"}
    inactive_border_color ${c "outline_variant"}
    bell_border_color ${c "error"}
    active_tab_foreground ${c "on_primary"}
    active_tab_background ${c "primary"}
    inactive_tab_foreground ${c "on_surface_variant"}
    inactive_tab_background ${c "surface_container"}
    tab_bar_background ${c "surface_container_low"}
    color0 ${c "surface_container_high"}
    color1 ${c "red"}
    color2 ${c "green"}
    color3 ${c "yellow"}
    color4 ${c "blue"}
    color5 ${c "magenta"}
    color6 ${c "cyan"}
    color7 ${c "on_surface_variant"}
    color8 ${c "outline"}
    color9 ${c "red"}
    color10 ${c "green"}
    color11 ${c "yellow"}
    color12 ${c "blue"}
    color13 ${c "magenta"}
    color14 ${c "cyan"}
    color15 ${c "on_surface"}
  '';

  gtk = pkgs.writeText "matugen-gtk.css" ''
    @define-color accent_color ${c "primary"};
    @define-color accent_bg_color ${c "primary"};
    @define-color accent_fg_color ${c "on_primary"};
    @define-color destructive_color ${c "error"};
    @define-color destructive_bg_color ${c "error"};
    @define-color destructive_fg_color ${c "on_error"};
    @define-color success_color ${c "green"};
    @define-color success_bg_color ${c "green"};
    @define-color success_fg_color ${c "surface"};
    @define-color warning_color ${c "yellow"};
    @define-color warning_bg_color ${c "yellow"};
    @define-color warning_fg_color ${c "surface"};
    @define-color error_color ${c "error"};
    @define-color error_bg_color ${c "error"};
    @define-color error_fg_color ${c "on_error"};
    @define-color window_bg_color ${c "surface"};
    @define-color window_fg_color ${c "on_surface"};
    @define-color view_bg_color ${c "surface_container_low"};
    @define-color view_fg_color ${c "on_surface"};
    @define-color headerbar_bg_color ${c "surface_container"};
    @define-color headerbar_fg_color ${c "on_surface"};
    @define-color headerbar_border_color ${c "outline_variant"};
    @define-color headerbar_backdrop_color ${c "surface"};
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
    @define-color card_bg_color ${c "surface_container_high"};
    @define-color card_fg_color ${c "on_surface"};
    @define-color card_shade_color rgba(0, 0, 0, 0.36);
    @define-color dialog_bg_color ${c "surface_container_high"};
    @define-color dialog_fg_color ${c "on_surface"};
    @define-color popover_bg_color ${c "surface_container_high"};
    @define-color popover_fg_color ${c "on_surface"};
    @define-color sidebar_bg_color ${c "surface_container_low"};
    @define-color sidebar_fg_color ${c "on_surface"};
    @define-color sidebar_backdrop_color ${c "surface"};
    @define-color sidebar_shade_color rgba(0, 0, 0, 0.36);
    @define-color shade_color rgba(0, 0, 0, 0.36);
    @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);
  '';

  btop = pkgs.writeText "matugen-btop.theme" ''
    theme[main_bg]="${c "surface"}"
    theme[main_fg]="${c "on_surface"}"
    theme[title]="${c "on_surface"}"
    theme[hi_fg]="${c "primary"}"
    theme[selected_bg]="${c "primary_container"}"
    theme[selected_fg]="${c "on_primary_container"}"
    theme[inactive_fg]="${c "outline"}"
    theme[graph_text]="${c "on_surface_variant"}"
    theme[meter_bg]="${c "surface_container_highest"}"
    theme[proc_misc]="${c "tertiary"}"
    theme[cpu_box]="${c "outline_variant"}"
    theme[mem_box]="${c "outline_variant"}"
    theme[net_box]="${c "outline_variant"}"
    theme[proc_box]="${c "outline_variant"}"
    theme[div_line]="${c "outline_variant"}"
    theme[temp_start]="${c "green"}"
    theme[temp_mid]="${c "yellow"}"
    theme[temp_end]="${c "red"}"
    theme[cpu_start]="${c "primary"}"
    theme[cpu_mid]="${c "secondary"}"
    theme[cpu_end]="${c "tertiary"}"
    theme[free_start]="${c "green"}"
    theme[free_mid]="${c "green"}"
    theme[free_end]="${c "green"}"
    theme[cached_start]="${c "blue"}"
    theme[cached_mid]="${c "blue"}"
    theme[cached_end]="${c "blue"}"
    theme[available_start]="${c "yellow"}"
    theme[available_mid]="${c "yellow"}"
    theme[available_end]="${c "yellow"}"
    theme[used_start]="${c "primary"}"
    theme[used_mid]="${c "primary"}"
    theme[used_end]="${c "primary"}"
    theme[download_start]="${c "secondary"}"
    theme[download_mid]="${c "secondary"}"
    theme[download_end]="${c "secondary"}"
    theme[upload_start]="${c "tertiary"}"
    theme[upload_mid]="${c "tertiary"}"
    theme[upload_end]="${c "tertiary"}"
  '';

  fish = pkgs.writeText "matugen-fish.fish" ''
    set -g fish_color_normal ${s "on_surface"}
    set -g fish_color_command ${s "primary"}
    set -g fish_color_keyword ${s "tertiary"}
    set -g fish_color_quote ${s "green"}
    set -g fish_color_redirection ${s "secondary"}
    set -g fish_color_end ${s "tertiary"}
    set -g fish_color_error ${s "error"}
    set -g fish_color_param ${s "on_surface_variant"}
    set -g fish_color_comment ${s "outline"}
    set -g fish_color_selection --background=${s "primary_container"}
    set -g fish_color_operator ${s "secondary"}
    set -g fish_color_escape ${s "tertiary"}
    set -g fish_color_autosuggestion ${s "outline"}
    set -g fish_color_cwd ${s "primary"}
    set -g fish_color_user ${s "green"}
    set -g fish_color_host ${s "primary"}
    set -g fish_color_search_match --background=${s "primary_container"}
    set -g fish_pager_color_progress ${s "outline"}
    set -g fish_pager_color_prefix ${s "primary"}
    set -g fish_pager_color_completion ${s "on_surface"}
    set -g fish_pager_color_description ${s "outline"}
    set -g fish_pager_color_selected_background --background=${s "primary_container"}
  '';

  qtRoles = {
    windowText = "on_surface";
    button = "surface_container";
    light = "surface_container_highest";
    midlight = "surface_container_high";
    dark = "surface_dim";
    mid = "outline_variant";
    text = "on_surface";
    brightText = "on_surface";
    buttonText = "on_surface";
    base = "surface_container_low";
    window = "surface";
    shadow = "shadow";
    highlight = "primary";
    highlightedText = "on_primary";
    link = "tertiary";
    linkVisited = "secondary";
    alternateBase = "surface_container";
    noRole = "surface";
    toolTipBase = "surface_container_highest";
    toolTipText = "on_surface";
    placeholderText = "on_surface_variant";
    accent = "primary";
  };

  qtOrder = [
    "windowText" "button" "light" "midlight" "dark" "mid" "text" "brightText"
    "buttonText" "base" "window" "shadow" "highlight" "highlightedText" "link"
    "linkVisited" "alternateBase" "noRole" "toolTipBase" "toolTipText"
    "placeholderText" "accent"
  ];

  qtList = disabled: lib.concatStringsSep ", " (map
    (role:
      let
        key = qtRoles.${role};
        dimmed = disabled && builtins.elem role [ "windowText" "text" "buttonText" "brightText" ];
      in
      c (if dimmed then "outline" else key))
    qtOrder);

  qt = pkgs.writeText "matugen-qt.conf" ''
    [ColorScheme]
    active_colors=${qtList false}
    disabled_colors=${qtList true}
    inactive_colors=${qtList false}
  '';

  template = input: output: extra: { input_path = "${input}"; output_path = "${home}/${output}"; } // extra;

  matugenConfig = {
    config.custom_colors = {
      red = palette.base.red;
      green = palette.base.green;
      yellow = palette.base.yellow;
      blue = palette.base.blue;
      magenta = palette.base.pink;
      cyan = palette.base.teal;
    };

    templates = {
      kitty = template kitty ".config/kitty/matugen-colors.conf" {
        post_hook = "pkill -USR1 -x kitty || true";
      };
      gtk3 = template gtk ".config/gtk-3.0/colors.css" { };
      gtk4 = template gtk ".config/gtk-4.0/colors.css" { };
      btop = template btop ".config/btop/themes/matugen.theme" { };
      fish = template fish ".config/fish/matugen.fish" { };
      qt5ct = template qt ".config/qt5ct/colors/matugen.conf" { };
      qt6ct = template qt ".config/qt6ct/colors/matugen.conf" { };
    };
  };
in
{
  home.packages = [ pkgs.matugen ];

  xdg.configFile."matugen/config.toml".source = toml.generate "matugen-config.toml" matugenConfig;

  home.activation.matugenSeed = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    marker="${config.xdg.cacheHome}/qs-niri/seeded"
    if [ ! -e "$marker" ]; then
      run mkdir -p "$(dirname "$marker")" \
        "$HOME/.config/kitty" "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0" \
        "$HOME/.config/btop/themes" "$HOME/.config/fish" \
        "$HOME/.config/qt5ct/colors" "$HOME/.config/qt6ct/colors"
      run ${pkgs.matugen}/bin/matugen image ${palette.wallpaper} --prefer saturation -m dark -t scheme-tonal-spot >/dev/null 2>&1 && touch "$marker" || true
    fi
  '';
}
