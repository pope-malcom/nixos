# Config for nixvim
{ flake-inputs, ... }:

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

      # Start scrolling when cursor is X lines from bottom
      scrolloff = 5;
    };

    extraConfigLua = ''

      -- Move to line start. If already there, move <dir>
      function move_dir_start_line(dir)
        col = vim.api.nvim_win_get_cursor(0)[2]
        vim.cmd("norm! ^")
        if (col == vim.api.nvim_win_get_cursor(0)[2]) then
          vim.cmd("norm! " .. dir .."^")
        end
      end

      --CUSTOM COMMANDS
      
      vim.api.nvim_create_user_command("MoveUpStartLine",
        function()
          move_dir_start_line("k")
        end, {});

      vim.api.nvim_create_user_command("MoveDownStartLine",
        function()
          move_dir_start_line("j")
        end, {});
    ''; 

    keymaps = [
      # In normal mode, <Up>/<Down> moves display lines
      {
        key = "<Up>";
        action = "g<Up>";
        mode = "n";
      }

      {
        key = "<Down>";
        action = "g<Down>";
        mode = "n";
      }


      # CTRL + <UP>/<DOWN> moves to line start and then moves
      {
        key = "<C-UP>";
        action = "<cmd>:MoveUpStartLine<CR>";
        mode = [ "n" "i" ];
      }
      
      {
        key = "<C-DOWN>";
        action = "<cmd>:MoveDownStartLine<CR>";
        mode = [ "n" "i" ];
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
