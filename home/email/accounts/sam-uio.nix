{ pkgs, lib, ... }:

let
  oauth = import ../oauth2.nix { inherit pkgs lib; };
in
{
  accounts.email.accounts = {
    sam-uio = 
      let
        address = "sam.holdcroft@its.uio.no";
        userName = "samho@uio.no";
      in {
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
            "Drafts"
            "Archive"
            "Trash"
            "Sent Items"
          ];
          subFolders = "Verbatim"; # Maintain folder structure of remote
          extraConfig.account.AuthMechs = "XOAUTH2";
        };

        imap = {
          authentication = "xoauth2";
          host = "outlook.office365.com";
          port = 993;
        };
        smtp = {
          # authentication = "xoauth2";
          host = "smtp.office365.com";
          port = 587;
          tls.useStartTls = true;
        };

    };
  };
}
