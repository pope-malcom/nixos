# home-manager config for zsh
{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Git aliases
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gp = "git push";
      gca = "git commit -A";
    };

    # Keybinds for deleting word/lines match forward word/line 
    initContent = ''
      bindkey "^w" backward-kill-line
      bindkey "\ew" backward-kill-word
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "z"     # Adds z command
      ];
      theme = "robbyrussell";
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
        "ga *" "gc *" "gs *" "gp *" "gca *" 
        "z *"
      ];
    };
  };
}
