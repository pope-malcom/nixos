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

  # Add aliases to auto use bat
  programs.zsh.shellAliases = {
    cat = "bat --decorations=never --paging=never";
    less = "bat --pager=less";
    man = "batman";
    diff = "batdiff --paging=never --decorations=never";
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
  
  # ripgrep
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
