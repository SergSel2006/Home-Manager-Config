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
  };
in
{
  imports = [ ../noctalia/noctalia.nix ];
  # Generating configs in nix to spite original flake
  xdg.configFile = {
    "config" = {
      source = (pkgs.formats.toml {} ).generate "driftwm-config" configuration;
      target = "driftwm/config.toml";
    };
  };
  home.packages = [];
  programs.fuzzel = {
    enable = true;
  };
}
