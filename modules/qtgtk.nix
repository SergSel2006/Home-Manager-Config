{ config, pkgs, ... }:
let
  qtct_settings = {
    Appearance = {
      icon_theme = "Papirus-Dark";
      style = "Fusion";
      color_scheme_path = "${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf";
      custom_palette = true;
    };
    Fonts = {
      fixed = "\"Adwaita Mono,12\"";
      general = "\"Adwaita Sans,12\"";
    };
    Interface = {
      buttonbox_layout = 2;
      keyboard_scheme = 3;
    };
  };
in
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    dotIcons.enable = true;
    name = "Bibata_Ghost";
    package = pkgs.bibata-cursors-translucent;
    size = 32;
  };
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Adwaita mono" ];
      sansSerif = [ "Adwaita Sans Light" ];
      serif = [ "Adwaita Serif" ];
    };
    hinting = "slight";
    subpixelRendering = "rgb";
  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    qt5ctSettings = qtct_settings;
    qt6ctSettings = qtct_settings;
  };
  gtk = {
    enable = true;
    gtk3.enable = true;
    theme.name = "adw-gtk3-dark";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
