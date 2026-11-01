{ pkgs, ... }:

{
  users.users  = {
    "nixremote" = {
      isNormalUser = true;
      group = "nogroup";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh3cHleGxX1LbjDuy94YyQ+5raMcmPI4osLMj1qg5Oi root@Laptop-NixOS"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAXaRiFWJd2xDMCPrQGhp+1bayEe9iCOky7vsGf2K2iA root@nix-desktop"
      ];
    };
  };
  nix.settings = {
    extra-substituters = [
      "ssh-ng://Laptop-NixOS"
      "ssh-ng://nix-desktop"
    ];
    trusted-public-keys = [
      "Laptop-NixOS:ZSEvdCPA1JVFzzaYcN+tQdDg+CzQiHBqasDWa8Spe8E="
      "nix-desktop.local:4mLe4OwLaMRXVOUD/QSKMj2RHibXDVU/ONoMqDywaEY="
    ];
  };
}
