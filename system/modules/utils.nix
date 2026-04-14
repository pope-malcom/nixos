# Configure system utility programs

{ config, pkgs, ... }:

{
  programs.nano = {
    enable = true;
    nanorc = ''
      set autoindent
      set guidestripe 80
      set linenumbers 
      set positionlog
      set tabsize 2
      set tabstospaces
    '';
  };

  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  environment.systemPackages = with pkgs; [
    # System packages to install
    pavucontrol
    teams-for-linux

    segger-jlink
    gcc-arm-embedded
  ];
  
  # TODO Look at moving this to home-manager
  nixpkgs.config.segger-jlink.acceptLicense = true;
  # TODO check for progress on https://github.com/NixOS/nixpkgs/pull/447868
  nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-874" ];
}
