let 
  sergsel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFC+iZ6wHIj80q0VotIjBMnSHy8rU96zEfSmSYQ2ueyA";
  users = [ sergsel ];

  Laptop-NixOS = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUhDAiCkMQlER8X8SaOF+2w3059dzqYnPsQTwduPeDC";
  systems = [ Laptop-NixOS ];
in {
  "syncthing-cert.age".publicKeys = [ sergsel ];
  "syncthing-key.age".publicKeys = [ sergsel ];
}
