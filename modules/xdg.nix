{ config, ... }:

{
  xdg = {
    enable = true;
    localBinInPath = true;
    autostart.enable = true;
    configFile."git-signers" = {
      source = ../dotfiles/allowed-signers;
      target = "git/allowed-signers";
    };
  };
}
