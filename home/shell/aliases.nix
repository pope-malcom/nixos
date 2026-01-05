# Alises
{ ... }:

{
  # Simple aliases for all shells
  home.shellAliases = {
    cat = "bat --decorations=never --paging=never";
    less = "bat --pager=less";
    man = "batman";
    diff = "batdiff --paging=never --decorations=never";
    
    nv = "nvim";

    # Git aliases
    ga = "git add";
    gc = "git commit";
    gca = "git commit -a";
    gcam = "git commit -am";
    gcm = "git commit -m";
    gs = "git status";
    gp = "git push";
    gd = "git diff HEAD";
  };

}
