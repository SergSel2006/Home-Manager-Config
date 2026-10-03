{ config, ... }:

{
  xdg.configFile = {
    "config" = {
      source = ./config.toml;
      target = "driftwm/config.toml";
    };
  };
}
