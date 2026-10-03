{
  config,
  ...
}:

{
  imports = [
    ./rules.nix
    ./noctalia.nix
    ./animations.nix
  ];

  xdg.configFile = {
    "binds" = {
      source = ./binds.kdl;
      target = "niri/binds.kdl";
    };
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
        {
          workspace._args = [ "󰻞 Чатики" ];
        }
        {
          workspace._args = [ "󰝚 Музыка" ];
        }
        {
          workspace._args = [ "󰺷 Игры" ];
        }
      ];
    };
    extraConfig = ''
      include "${config.xdg.configHome}/niri/binds.kdl"
      include optional=true "${config.xdg.configHome}/niri/noctalia.kdl"
    '';
  };
}
