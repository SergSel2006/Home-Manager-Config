{ ... }:

{
  wayland.windowManager.niri.settings.animations = {
    workspace-switch.spring._props = {
      damping-ratio = 0.8;
      stiffness = 1000;
      epsilon = 0.0001;
    };
    window-open = {
      duration-ms = 300;
      curve._args = [ "cubic-bezier" 0.5 1.45 0.60 1 ];
    };
    window-close = {
      duration-ms = 500;
      curve = "ease-out-expo";
    };
    horizontal-view-movement = {
      duration-ms = 300;
      curve = "ease-out-expo";
    };
    window-movement = {
      duration-ms = 300;
      curve = "ease-out-expo";
    };
    window-resize = {
      duration-ms = 300;
      curve = "ease-out-expo";
    };
    screenshot-ui-open = {
      duration-ms = 200;
      curve = "ease-out-quad";
    };
    overview-open-close = {
      duration-ms = 250;
      curve = "ease-out-cubic";
    };
  };
}
