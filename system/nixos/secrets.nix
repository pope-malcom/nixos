# Setup keyring and secret management
{ config, pkgs, lib, ... }:

{
  services.gnome = {
    # Enable gnome keyring
    gnome-keyring.enable = true;

    #Enable gnome keyring to manage ssh keys
    gcr-ssh-agent.enable = true;
  };

  # Enable seahorse for GUI keyring management 
  programs.seahorse.enable = true;

  # Unlock keyring on login
  security.pam.services = {
    login.enableGnomeKeyring = true;
    # All of this is needed because greetd does not work well with unlocking keyrings automatically
    # TODO: replace greetd with a more compliant greeter
    greetd =
      let
        pam_fde_boot_pw = pkgs.callPackage ./pam_fde_boot_pw.nix {};
      in
      lib.mkIf config.services.greetd.enable {
        text = ''
          auth          substack        login
          account       include         login
          password      substack        login
          session       optional        ${pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so inject_for=gkr
          session       include         login
        '';
      };
  };

  environment.systemPackages = [
    # Secret-tool
    pkgs.libsecret
  ];
}
