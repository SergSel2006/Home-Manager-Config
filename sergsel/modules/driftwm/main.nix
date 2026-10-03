{ pkgs, ... }:

{
  xdg.configFile = {
    "config" = {
      source = ./config.toml;
      target = "driftwm/config.toml";
    };
  };
  home.packages = [];
  programs.fuzzel = {
    enable = true;
  };
}
