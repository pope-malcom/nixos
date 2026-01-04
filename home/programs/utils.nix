# Configure user utilities

{ config, pkgs, ... }:

{
  # bat: cat with wings
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
    ];
    config = {
      italic-text = "always";
      map-syntax = [ "*.ino:C++" ]; # Render arduino files as C++
      pager = "less";
      tabs = "2";
    };
  };

  # delta: bat style pager for git, diff, grep and blame
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      hyperlinks = true;
      line-numbers = true;
      side-by-side = true;
    };
  };
  
  # Ripgrep (https://github.com/BurntSushi/ripgrep)
  programs.ripgrep = {
    enable = true;
  };

  # Auto pipe ripgrep output to delta
  programs.zsh.initContent = ''
    rg() { rg $@ --json | delta }
  '';

  home.packages = with pkgs; [
    
    # Archives
    zip
    unzip

    # Networking
    socat # Modern replacement of netcat
    nmap

    # System monitoring
    btop
  ];
}
