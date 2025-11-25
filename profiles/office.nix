{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/services
  ];

  local = {
    services.syncthing.enable = lib.mkDefault true;
  };
}
