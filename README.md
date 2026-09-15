# My Personal home manager configuration

Note: Direnv and `nix develop` shells are available with `nil` LSP and `age` command for convenience if you ever wanted to fork my configuration.

This configuration uses flake, but mostly it is without 3rd party flakes, only one being agenix, without it I could not manage my syncthing node and put it into public.

So, this is my pretty small and simple configuration, with niri and noctalia set up, with a bit of configuration tweaks.

Mainly, niri uses Meta+WASD for window navigation, Meta+E for noctalia app center. Also, it uses Copilot Key to launch terminal because I have it and I don't have any other use for it (and to laugh at Microslop). You can find more in `dotfiles/niri/binds.kdl`.

Another major stuff is applications I use are also here and not in my system configuration (I think that system on NixOS should really have very minimal amount of software to just start DM and launch my session), except the steam. 

I hope you like it if you want to try it

NB!: This configuration uses default generated ssh key which is likely to be in your home, and I don't know what will happen if it is wrong, but here, so please don't foreget to either disable it or change for your setup. Look up agenix for instructions on how to configure it.
