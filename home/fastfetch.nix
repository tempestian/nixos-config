{ config, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${config.home.homeDirectory}/.config/fastfetch/rimuru.png";
        type = "kitty-direct";
        width = 28;
        height = 14;
        padding = {
          top = 1;
          left = 1;
          right = 2;
        };
      };
      display = {
        separator = " 󰄾 ";
        color = {
          keys = "cyan";
          title = "blue";
        };
      };
      modules = [
        {
          type = "title";
          format = "  {user-name}  {host-name}";
        }
        {
          type = "custom";
          format = "  ──────────────────────────────────────";
        }
        {
          type = "os";
          key = "  󰣚 OS";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "  󰌽 Kernel";
          keyColor = "cyan";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "  󰏖 Packages";
          keyColor = "cyan";
        }
        {
          type = "wm";
          key = "  󱂬 Compositor";
          keyColor = "blue";
        }
        {
          type = "shell";
          key = "  󰞷 Shell";
          keyColor = "cyan";
        }
        {
          type = "terminal";
          key = "  󰞷 Terminal";
          keyColor = "blue";
        }
        {
          type = "cpu";
          key = "  󰍛 CPU";
          keyColor = "cyan";
        }
        {
          type = "gpu";
          key = "  󰘚 GPU";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "  󰘚 Memory";
          keyColor = "cyan";
        }
        {
          type = "disk";
          key = "  󰋊 Disk";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "  ──────────────────────────────────────";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  xdg.configFile."fastfetch/rimuru.png".source = ./assets/rimuru.png;
}
