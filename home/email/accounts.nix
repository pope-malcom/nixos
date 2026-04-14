# Add email accounts for programs to use
{ ... }:
{
  accounts.email.accounts = {
    pomal = {
      enable = true;
      primary = true;
      address = "pope.malcom@proton.me";
      realName = "pomal";
    };
    sam-uio = {
      enable = true;
      address = "sam.holdcroft@its.uio.no";
      aliases = [ "samho@uio.no" ];
      flavor = "outlook.office365.com";
      realName = "Sam";
      thunderbird.enable = true;
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.pomal = {
      isDefault = true;
      #name = "Pope Malcom";
    };
  };
}
