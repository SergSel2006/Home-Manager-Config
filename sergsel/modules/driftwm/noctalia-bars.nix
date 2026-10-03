{ ... }:

{
  programs.noctalia.settings = {
    dock = {
      enable = true;
      position = "left";
      auto_hide = true;
      launcher_position = "end";
      reserve_space = false;
    };
    bar.default.enabled = true;
    bar.default.position = "bottom";
  };

}
