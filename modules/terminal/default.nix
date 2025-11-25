{ config, lib, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./wezterm.nix
  ];

  options.local.programs.terminal = {
    theme = lib.mkOption {
      type = lib.types.str;
      default = "One Dark (Gogh)";
      description = "Color scheme (applied to all terminals)";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.98;
      description = "Window opacity (applied to all terminals)";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "JetbrainsMono Nerd Mono";
        description = "Font family (applied to all terminals)";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Font size (applied to all terminals)";
      };
    };
  };
}
