# Add email accounts for programs to use
{ pkgs, lib, ... }:

{
  accounts.email.accounts = {
    pomal = {
      enable = true;
      primary = true;
      address = "pope.malcom@proton.me";
      realName = "pomal";
    };
    sam-uio = 
      {
        # TODO This needs to be redone when home-manager thunderbird package updates
        enable = true;
        aliases = [ "samho@uio.no" ];
        address = "sam.holdcroft@its.uio.no";
        userName = "samho@uio.no";
        flavor = "gmail.com"; # Not true, but it forces thunderbird.nix to set the smtp to xoauth2
        realName = "Sam";
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

  programs.thunderbird = {
    enable = true;
    profiles.pomal = {
      isDefault = true;
    };
  };
}
