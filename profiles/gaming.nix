{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/system
  ];

  local = {
    programs.coolercontrol.enable = lib.mkDefault true;
    programs.lact.enable          = lib.mkDefault true;
  };
}
