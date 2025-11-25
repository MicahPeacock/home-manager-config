{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.kitty;
  shared = config.local.programs.terminal;
in
{
  options.local.programs.kitty = {
    enable = lib.mkEnableOption "Enable Kitty, a fast, feature-rich, GPU-based terminal emulator";
    theme = lib.mkOption {
      type = lib.types.str;
      default = shared.theme;
      description = "Color scheme to use in Kitty";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = shared.opacity;
      description = "Window opacity to use in Kitty";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = shared.font.name;
        description = "Font family to use in Kitty";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = shared.font.size;
        description = "Size of font (in px) to use in Kitty";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kitty-themes
    ];

    programs.kitty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.kitty;
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration  = true;
        enableFishIntegration = true;
      };
      font = {
        name = cfg.font.name;
        size = cfg.font.size;
      };
    };
  };
}
