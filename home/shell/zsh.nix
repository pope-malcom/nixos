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

    oh-my-zsh = {
      enable = true;
      plugins = [
        "z"     # Adds z command
      ];
      theme = "robbyrussell";
    };
 
    history.size = 10000;
    history.share = false;
    history.ignoreAllDups = true;
    history.ignoreSpace = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *" 
      "pkill *" 
      "cp *" 
      "git *"
      "ga *" "gc *" "gs *" "gp *" "gca *" 
      "z *"
    ];
  };
}
