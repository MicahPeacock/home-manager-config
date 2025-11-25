{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.bash;
in
{
  options.local.programs.bash = {
    enable = lib.mkEnableOption "Enable bash interactive shell";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;

      initExtra = ''
        fastfetch --logo-type kitty
      '';
    };
  };
}
