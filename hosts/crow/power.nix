# Power profile configuration

{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  # Set lid close functions
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  # Automatically hibernate after period of inactivity
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';

  # auto-cpufreq profiles
  programs.auto-cpufreq.enable = true;
  programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "powersave";
      turbo = "auto";
    };
  };

  # power-profiles-daemon conflicts with auto-cpufreq
  services.power-profiles-daemon.enable = false;

  # tlp should not be active at the same time as auto-cpufreq
  services.tlp.enable = false;
}
