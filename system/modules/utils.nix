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
  ];
}
