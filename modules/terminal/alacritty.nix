{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.alacritty;
  shared = config.local.programs.terminal;
in
{
  options.local.programs.alacritty = {
    enable = lib.mkEnableOption "Enable Alacritty, a fast, cross-platform, OpenGL terminal emulator";
    theme = lib.mkOption {
      type = lib.types.str;
      default = shared.theme;
      description = "Color scheme to use in Alacritty";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = shared.opacity;
      description = "Window opacity to use in Alacritty";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = shared.font.name;
        description = "Font family to use in Alacritty";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = shared.font.size;
        description = "Font size (in px) to use in Alacritty";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;
    };
  };
}
