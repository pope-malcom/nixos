{ pkgs, ... }:

let
  address = "sam.holdcroft@its.uio.no";
  userName = "samho@uio.no";
  profileName = "sam-uio";
in
{
  accounts.email.accounts = {
    ${profileName} = {
      inherit address userName;
      enable = true;
      aliases = [ userName ];
      realName = "Sam";
      maildir.path = "Work";
      passwordCommand = "${pkgs.pizauth}/bin/pizauth show ${profileName}"; # Handles XOAuth2 connections
      neomutt = {
        enable = true;
        mailboxType = "maildir";
        mailboxName = "Work";
        extraConfig = ''
          set record = '+Sent\ Items'
        '';
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
        authentication = "xoauth2";
        host = "smtp.office365.com";
        port = 587;
        tls.useStartTls = true;
      };
    };
  };

  services.pizauth = {
    enable = true;
    accounts.${profileName} = {
      name = profileName;
      authUri = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      tokenUri = "https://login.microsoftonline.com/common/oauth2/v2.0/token";
      clientId = "9e5f94bc-e8a4-4e73-b8be-63364c29d753";
      loginHint = userName;
      scopes = [
        "https://outlook.office365.com/IMAP.AccessAsUser.All"
        "https://outlook.office365.com/SMTP.Send"
        "offline_access"
      ];
    };
  };
}
