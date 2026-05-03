# Load email configs
{ ... }:

{
  imports = [
    ./neomutt.nix
    ./accounts/sam-uio.nix
  ];
}
