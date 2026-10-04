{ pkgs, ... }:

{
  home.packages = [
    pkgs.adwaita-fonts
    pkgs.adw-gtk3
    pkgs.zip
    pkgs.unzip
    pkgs.fzf
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableGitIntegration = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.name = "SergSel2006";
      user.email = "sergsel2006@mail.ru";
    };
  };
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
        };
      }
    );
  };
  programs.neovim.enable = true;
}
