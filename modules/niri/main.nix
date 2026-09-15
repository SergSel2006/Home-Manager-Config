{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./rules.nix
  ];

  xdg.configFile = {
    "animations" = {
      source = ../../dotfiles/niri/animations.kdl;
      target = "niri/animations.kdl";
    };
    "binds" = {
      source = ../../dotfiles/niri/binds.kdl;
      target = "niri/binds.kdl";
    };
  };
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };
  wayland.windowManager.niri = {
    enable = true;
    checkConfig = false;
    settings = {
      input = {
        keyboard.xkb = {
          layout = "us,ru";
          options = "grp:caps_toggle,compose:ralt";
        };
        keyboard.numlock = { };
        touchpad.tap = { };
        touchpad.natural-scroll = { };
      };
      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        focus-ring.off = { };
        border.width = 4;
        struts = {
          left = 4;
          right = 4;
        };
      };
      cursor = {
        xcursor-theme = config.home.pointerCursor.name;
        xcursor-size = config.home.pointerCursor.size;
      };
      prefer-no-csd = { };
      screenshot-path = "~/Изображения/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      _children = [
        {
          output = {
            _args = [ "eDP-1" ];
            mode = "1920x1080@60.001";
            variable-refresh-rate = { };
          };
        }
      ];
    };
    extraConfig = ''
      include "${config.xdg.configHome}/niri/binds.kdl"
      include "${config.xdg.configHome}/niri/animations.kdl"
      include optional=true "${config.xdg.configHome}/niri/noctalia.kdl"
    '';
  };
}
