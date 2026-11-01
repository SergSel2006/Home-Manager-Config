{ ... }:

{
  imports = [
    # ./rules.nix
    ../noctalia/noctalia.nix
    # ./animations.nix
    ./noctalia-bars.nix
    # ./main.nix  TODO: Fix Niri configuration
    # Just placing kdl files under home-manager control
    # should be fine.
  ];
}
