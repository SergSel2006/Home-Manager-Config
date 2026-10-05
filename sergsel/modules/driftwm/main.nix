{ pkgs, ... }:
let
  configuration = {
    window_placement = "auto";
    input = {
      keyboard = {
        layout = "us,ru";
        options = "grp:caps_toggle,compose:ralt";
      };
    };
    autostart = [ "squeekboard" ];
    background = {
      type = "none";
    };
    snap = {
      corners = true;
      centers = true;
    };
    decorations = {
      corner_radius = 24;
      default_mode = "minimal";
    };
    keybindings = {
      "mod+d" = "spawn noctalia msg panel-toggle launcher";
      "mod+l" = "spawn noctalia msg session lock";
      "XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
      "XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
      "XF86AudioMute" = "spawn noctalia msg volume-mute";
      "XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
      "XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";
      "Print" = "spawn noctalia msg screenshot-fullscreen";
      "shift+Print" = "spawn noctalia msg screenshot-region";
      "ctrl+Print" = "spawn noctalia msg screenshot-fullscreen all";
    };
    window_rules = [
      {
        app_id = "Alacritty";
        blur = true;
      }
    ];
  };
  toml = pkgs.formats.toml {};
in
{
  imports = [ ../noctalia/noctalia.nix ./noctalia-bars.nix ];
  # Generating configs in nix to spite original flake
  xdg.configFile = {
    "config" = {
      source = toml.generate "driftwm-config" configuration;
      target = "driftwm/config.toml";
    };
  };
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
    };
  };
  programs.fuzzel.enable = true;
}
