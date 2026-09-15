{ ... }:

{
  wayland.windowManager.niri.settings._children = [
    {
      window-rule = {
        geometry-corner-radius = 24;
        clip-to-geometry = true;
      };
    }
    {
      window-rule = {
        match._props = {
          app-id = "firefox";
          title = "Картина в Картинке";
        };
        open-floating = true;
      };
    }
    {
      window-rule = {
        match._props = {
          app-id = "org.keepassxc.KeePassXC";
        };
        block-out-from = "screen-capture";
      };
    }
    {
      window-rule = {
        _children = [
          {
            match._props = {
              app-id = "pcmanfm-qt";
              title = "Перемещение файлов";
            };
          }
          {
            match._props = {
              app-id = "pcmanfm-qt";
              title = "Вставлен съёмный носитель";
            };
          }
          {
            match._props = {
              app-id = "lxqt-archiver";
              title = "Ход операции";
            };
          }
        ];
        default-floating-position._props = {
          x = 10;
          y = 10;
          relative-to = "top-right";
        };
        open-focused = false;
        open-floating = true;
      };
    }
    {
      window-rule = {
        match._props = {
          app-id = "Alacritty";
        };
        background-effect = {
          xray = false;
          blur = true;
          noise = 0.05;
          saturation = 2;
        };
      };
    }
    {
      layer-rule = {
        _children = [
          {
            match._props = {
              namespace = "noctalia-panel";
            };
          }
          {
            match._props = {
              namespace = "noctalia-osd";
            };
          }
          {
            match._props = {
              namespace = "noctalia-notification";
            };
          }
          {
            match._props = {
              namespace = "noctalia-attached-panel";
            };
          }
        ];
        background-effect = {
          xray = false;
        };
      };
    }
    {
      layer-rule = {
        match._props = {
          namespace = "noctalia-backdrop";
        };
        place-within-backdrop = true;
      };
    }
  ];
}
