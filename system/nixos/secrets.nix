# Setup keyring and secret management
{ pkgs, ... }:

{
  services.gnome = {
    # Enable gnome keyring
    gnome-keyring.enable = true;

    #Enable gnome keyring to manage ssh keys
    gcr-ssh-agent.enable = true;
  };

  # Enable seahorse for GUI keyring management 
  programs.seahorse.enable = true;

  environment.systemPackages = [
    pkgs.libsecret
  ];
}
