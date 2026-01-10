# Config for nixvim
{ flake-inputs, pkgs, ... }:

{
  imports = [
    flake-inputs.nixvim.homeModules.nixvim
  ];

  # https://nix-community.github.io/nixvim/25.11/
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
      # Line numbers
      number = true;

      # Indents
      shiftwidth = 2;
      smarttab = true;
      expandtab = true;
      tabstop = 8;
      softtabstop = 0;

      # Wrapping
      textwidth = 0;
      wrapmargin = 0;
      wrap = true;
      linebreak = true; # break by word instead of character

      # Wrap cursor movements to next/previous line
      whichwrap = "<,>,[,],b,s";

      # Always keep cursor in centre of window
      scrolloff = 999;
    };
    
    extraPlugins = [ 
      # Treewalker: Move around based on syntax tree
      #pkgs.vimPlugins.treewalker-nvim
      # Version in nixpkgs is broken, so a manual import is needed 
      # TODO check this again in NixOS 26.05
      (pkgs.vimUtils.buildVimPlugin {
        name = "treewalker";
        src = pkgs.fetchFromGitHub {
          owner = "aaronik";
          repo = "treewalker.nvim";
          rev = "3d5148e160ed9728b3275d37d06ea028cef5f43b";
          hash = "sha256-no0GhR12ryvDRGhcB8P+YA1sCi8qbiESnczr7rJl6gA=";
        };
      })
    ];


    extraConfigLua = ''

      -- Treewalker config
      require('treewalker').setup({
      	scope_confined = true;
      })
    ''; 

    keymaps = [
      # <Up>/<Down> moves display lines
      {
        key = "<Up>";
        action = "gk";
        mode = "n";
      }

      {
        key = "<Down>";
        action = "gj";
        mode = "n";
      }


      # Shift + <DIR> moves 10 lines
      {
        key = "<S-UP>";
        action = "10k";
        mode = "n";
      }

      {
        key = "<S-DOWN>";
        action = "10j";
        mode = "n";
      }


      # CTRL + <UP>/<DOWN> moves to line start and then moves
      {
        key = "<C-UP>";
        action = "<cmd>Treewalker Up<cr>";
        mode = [ "n" "v" ];
      }
      
      {
        key = "<C-DOWN>";
        action = "<cmd>Treewalker Down<cr>";
        mode = [ "n" "v" ];
      }
      
      {
        key = "<C-LEFT>";
        action = "<cmd>Treewalker Left<cr>";
        mode = [ "n" "v" ];
      }
      
      {
        key = "<C-RIGHT>";
        action = "<cmd>Treewalker Right<cr>";
        mode = [ "n" "v" ];
      } 
    ];
    
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
