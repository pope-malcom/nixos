{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS hardware support for Framework 13 AMD AI 300 series
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Auto-cpufreq: throttle CPU for power purposes
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-flatpaks: declarative flatpak installs
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = inputs@{
    nixpkgs, 
    home-manager, 
    nixos-hardware, 
    auto-cpufreq,
    nix-flatpak,
    ... 
  }: {
    nixosConfigurations.crow = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts
        ./modules
        ./system
        ./users
      ];
    };
  };
}
