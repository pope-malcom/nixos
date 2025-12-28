# Configure git

{ config, pkgs, ... }:

{
  # Confgure git
  programs.git = {
    enable = true;
    settings = {
      user.name = "pope-malcom";
      user.email = "pope.malcom@proton.me";
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
