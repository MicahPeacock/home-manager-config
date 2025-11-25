{ config, pkgs, ... }:

{
  imports = [
    ./coolercontrol.nix
    ./lact.nix
  ];
}
