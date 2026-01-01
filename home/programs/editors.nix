# Configs for text editors
{ ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    extraConfig = ''
      set whichwrap+=<,>,h,l,[,]<M-D-x>

      set autocomplete

      set autoindent
      set shiftwidth=2 
      set smarttab
      set expandtab
      set tabstop=8
      set softtabstop=0
    '';
  };

}
