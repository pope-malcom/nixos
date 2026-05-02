# Add email accounts for programs to use
{ pkgs, lib, ... }:

let
  oauth = import ./oauth2.nix { inherit pkgs lib; };
in
{
  home.packages = [ oauth ];
  accounts.email.maildirBasePath = "Mail";
  accounts.email.accounts = {
    pomal = {
      enable = true;
      primary = true;
      address = "pope.malcom@proton.me";
      realName = "pomal";
    };

    sam-uio = 
      let
        address = "sam.holdcroft@its.uio.no";
        userName = "samho@uio.no";
      in    
      {
        inherit address userName;
        enable = true;
        aliases = [ userName ];
        realName = "Sam";
        maildir.path = "Work";
        passwordCommand = "${lib.getExe oauth} ${userName}"; # Handles XOAuth2 connections
        neomutt = {
          enable = true;
          mailboxType = "maildir";
          mailboxName = "Work";
        };
        msmtp = {
          enable = true;
          extraConfig.auth = "xoauth2";
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          remove = "both";
          patterns = [ 
            "INBOX"
            "Archive"
            "Trash"
            "Deleted Items"
            "Sent Items"
          ];
          subFolders = "Verbatim"; # Maintain folder structure of remote
          extraConfig.account.AuthMechs = "XOAUTH2";
        };
          

        imap = {
          authentication = "xoauth2";
          host = lib.mkForce "outlook.office365.com";
          port = 993;
        };
        smtp = {
          # authentication = "xoauth2";
          host = lib.mkForce "smtp.office365.com";
          port = 587;
          tls.useStartTls = true;
        };
      };
  };

  programs.neomutt = {
    enable = true;
    vimKeys = false; # With this set only some messages open
  };

  programs.msmtp.enable = true;
  programs.mbsync = {
    enable = true;
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; }; # MSMTP does not support XOAUTH2 by default, this has to be added
  };
}
