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
        # TODO This needs to be redone when home-manager thunderbird package updates
        inherit address userName;
        enable = true;
        aliases = [ userName ];
        flavor = "gmail.com"; # Not true, but it forces thunderbird.nix to set the smtp to xoauth2
        realName = "Sam";
        maildir.path = "Work";
        passwordCommand = "${lib.getExe oauth} ${userName}";
        thunderbird = {
          enable = true;
          settings = id: {
            # This should work, but it doesn't
            "mail.smtpserver.smpt_${id}.authMethod" = 10;
            "mail.server.server_${id}.authMethod" = lib.mkDefault 10; # 10 is XOAuth

            "mail.imap.auto_unsubscribe_from_noselect_folders" = false;
            #"mail.server.server_${id}.using_subscription" = false;
          };
        };
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
          subFolders = "Verbatim";
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
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; };
  };

  programs.thunderbird = {
    enable = true;
    profiles.pomal = {
      isDefault = true;
    };
  };
}
