# home-manager config for zsh
{ ... }:

{
  # fzf: Fuzzy finder
  # https://github.com/junegunn/fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # eza: ls replacement
  # https://github.com/eza-community/eza
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--header"
      "--time-style=long-iso"
      "--hyperlink"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Keybinds for deleting word/lines match forward word/line 
    initContent = ''
      bindkey "^w" backward-kill-line
      bindkey "\ew" backward-kill-word
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
      ];
    };

    history = {
      size = 10000;
      share = false;
      ignoreAllDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = [
        "rm *" 
        "pkill *" 
        "cp *" 
        "git *"
        "ga *" "gs *" "gp *" "gc *" "gca *" "gcam *" "gcm *" "gd *" "gl *" 
        "z *"
      ];
    };
  };
}
