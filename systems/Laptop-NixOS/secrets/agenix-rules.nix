let
  sergsel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFC+iZ6wHIj80q0VotIjBMnSHy8rU96zEfSmSYQ2ueyA";
  users = [ sergsel ];

  Laptop-NixOS = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUhDAiCkMQlER8X8SaOF+2w3059dzqYnPsQTwduPeDC";
  systems = [ Laptop-NixOS ];
in
{
  "i2pd-port.age".publicKeys = systems;
  "i2pd-site.age".publicKeys = systems;
  "tor-site.age".publicKeys = systems;
  "zt-identity-laptop.age".publicKeys = [ Laptop-NixOS ];
  "nix-key-laptop.age".publicKeys = [ Laptop-NixOS ];
  "searxng.age".publicKeys = [ Laptop-NixOS ];
}
