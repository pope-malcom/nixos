# Add default home configurations
{ ... }:
{
  imports = [
    ./browsers
    ./desktop
    ./email
    ./programs
    ./shell
  ];
}
