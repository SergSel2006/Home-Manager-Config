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
    dataFile = {
      "arch-tan" = {
        source = ../data/wallpapers/Arch-Tan.png;
        target = "wallpapers/Arch-Tan.png";
      };
      "nordic" = {
        source = ../data/wallpapers/wallpaper.png;
        target = "wallpapers/wallpaper.png";
      };
      "galaxy" = {
        source = ../data/wallpapers/galaxy.png;
        target = "wallpapers/galaxy.png";
      };
    };
  };
}
