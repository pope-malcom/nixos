# State version variable

{ config, pkgs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database ver>
  # on your system were taken. It‘s perfectly fine and recommended t>
  # this value at the release version of the first install of this s>
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/option>
  system.stateVersion = "25.11";
}
