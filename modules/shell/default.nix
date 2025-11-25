{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs;

  enabled = lib.count (x: x) [
    (cfg.bash.enable or false)
    (cfg.zsh.enable  or false)
    (cfg.fish.enable or false)
  ];
in
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  options.local.programs.shell = {
    default = lib.mkOption {
      type = lib.types.enum [ "bash" "zsh" "fish" ];
      default = "bash";
      description = "Default interactive shell";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.shell.default == "bash") {
      local.programs.bash.enable = lib.mkDefault true;
    })
    (lib.mkIf (cfg.shell.default == "zsh") {
      local.programs.zsh.enable  = lib.mkDefault true;
    })
    (lib.mkIf (cfg.shell.default == "fish") {
      local.programs.fish.enable = lib.mkDefault true;
    })

    {
      assertions = [{
        assertion = enabled <= 1;
        message = "Only one shell can be enabled.";
      }];
    }
  ];
}
