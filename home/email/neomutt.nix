# Add email accounts for programs to use
{ pkgs, lib, ... }:

let
  oauth = import ./oauth2.nix { inherit pkgs lib; };
in
{
  home.packages = [ oauth pkgs.w3m ];
  accounts.email.maildirBasePath = "Mail";
  accounts.email.accounts = {
    pomal = {
      enable = true;
      primary = true;
      address = "pope.malcom@proton.me";
      realName = "pomal";
    };
  };

  programs.neomutt = {
    enable = true;
    vimKeys = false; # With this set only some messages open
    sort = "reverse-last-date-received";
    extraConfig = ''
      set use_threads = threads
      # set sort = reverse-last-date-received
      set date_format = "%y/%m/%d %I:%M%p"
      set mailcap_path = "~/.config/neomutt/mailcap"
      
      set collapse_all = yes
      set uncollapse_new = yes

      auto_view text/html
      alternative_order text/plain text/enriched text/html
    '';
  };

  programs.msmtp.enable = true;
  programs.mbsync = {
    enable = true;
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; }; # MSMTP does not support XOAUTH2 by default, this has to be added
  };

  # Setup mailcap file
  home.file.".config/neomutt/mailcap" = {
    text = ''
      text/html; $BROWSER %s
      text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html -dump; copiousoutput;
    '';
  };
}
