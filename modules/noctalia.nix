{ config, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      audio = { enable-sounds = true; };
      calendar = {
        enabled = true;
      };
      idle = {
        behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
        behavior.lock = {
          action = "lock";
          enabled = true;
          timeout = 120.0;
        };
        behavior.lock-and-suspend = {
          action = "lock-and-suspend";
          enabled = true;
          timeout = 300.0;
        };
        behavior.screen-off = {
          action = "screen_off";
          enabled = true;
          timeout = 150.0;
        };
      };
      notification = { history_retention_hours = 72; };
      shell = {
        external_ip_enabled = true;
        font_family = "Adwaita Sans";
        launch_apps_as_systemd_services = true;
        password_style = "random";
        polkit_agent = true;
        screen_time_enabled = true;
        telemetry_enabled = true;
        launcher.show_app_actions = true;
        panel.transparency_mode = "glass";
      };
      theme = {
        community_palette = "Catppuccin Mocha Lavender";
        mode = "dark";
        source = "community";
        templates = {
          builtin_ids = [ "alacritty" "btop" "cava" "gtk3" "gtk4" "kcolorscheme" "niri" "qt" ];
          community_ids = [ "pywalfox" "telegram" "libreoffice" "neovim" "fastfetch" "obs" "papirus-icons" "bat" "fzf" ];
        };
      };
      wallpaper.directory = "${config.xdg.dataHome}/wallpapers";
    };
  };
}
