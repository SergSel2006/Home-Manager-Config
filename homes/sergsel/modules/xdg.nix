{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "git-signers" = {
        source = ../dotfiles/allowed-signers;
        target = "git/allowed-signers";
      };
      "vkBasalt" = {
        source = ../dotfiles/vkBasalt.conf;
        target = "vkBasalt/vkBasalt.conf";
      };
      "mpv" = {
        source = ../dotfiles/mpv.conf;
        target = "mpv/mpv.conf";
      };
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
      "reshade" = {
        source = pkgs.fetchgit {
          url = "https://github.com/renvertere/vk-reshade.git";
          rev = "94df8e74251a5738e8b5676ed9dbd2474ceaed00";
          hash = "sha256-QSICx4ofZHRPInytzxEu2F8tCswzWN/kB6Rgh0Au7Zg=";
        };
        target = "reshade";
      };
    };
    autostart.entries = [
      "${pkgs.retroshare}/share/applications/retroshare.desktop"
      "${pkgs.steam}/share/applications/steam.desktop"
      "${pkgs.telegram-desktop}/share/applications/org.telegram.desktop.desktop"
      "${pkgs.easyeffects}/share/applications/com.github.wwmm.easyeffects.desktop"
    ];
  };
}
