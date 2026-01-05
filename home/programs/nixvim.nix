# Config for nixvim
{ flake-inputs, ... }:

{
  imports = [
    flake-inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;

    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };

    autoCmd = [
      {
        desc = ''Restore cursor position upon file reopen'';
        event = ''BufReadPost'';
        pattern = ''*'';
        command = ''silent! normal! g`"zv'';
      }
    ];

    opts = {
      # Indents
      shiftwidth = 2;
      smarttab = true;
      expandtab = true;
      tabstop = 8;
      softtabstop = 0;
      
      # Wrap cursor movements to next/previous line
      whichwrap = "<,>,h,l,[,]";

      # Line numbers
      number = true;

      # Start scrolling when cursor is X lines from bottom
      scrolloff = 5;
    };
    
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
        };
      };

    };
  };
}
