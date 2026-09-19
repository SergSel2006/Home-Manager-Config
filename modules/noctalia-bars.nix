{ ... }:

{
  programs.noctalia.settings.bar = {
    default = {
      capsule = true;
      center = [ "group:g6" ];
      end = [
        "group:g7"
        "group:g2"
        "group:g3"
        "group:g4"
        "group:g5"
      ];
      start = [
        "privacy"
        "group:g1"
        "workspaces"
        "media"
      ];
      capsule_group = [
        {
          accordion = true;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g1";
          members = [
            "launcher"
            "wallpaper"
            "clipboard"
            "bar"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = false;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g2";
          members = [
            "notifications"
            "tray"
            "status"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = true;
          accordion_direction = "start";
          enabled = true;
          fill = "surface_variant";
          id = "g3";
          members = [
            "network"
            "bluetooth"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = false;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g4";
          members = [
            "brightness"
            "volume"
            "battery"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = true;
          accordion_direction = "start";
          enabled = true;
          fill = "surface_variant";
          id = "g5";
          members = [
            "control-center"
            "session"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = false;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g6";
          members = [
            "nightlight"
            "clock"
            "recorder"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
        {
          accordion = true;
          accordion_direction = "start";
          enabled = true;
          fill = "surface_variant";
          id = "g7";
          members = [
            "temp"
            "ram"
            "cpu"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
      ];
    };
  };
}
