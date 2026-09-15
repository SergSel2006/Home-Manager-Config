{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    modules/qtgtk.nix
    modules/niri/main.nix
    modules/xdg.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sergsel";
  home.homeDirectory = "/home/sergsel";
  home.language.base = "ru_RU.UTF-8";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.yandex-music
    pkgs.lxqt.pcmanfm-qt
    pkgs.lxqt.lxqt-archiver
    pkgs.telegram-desktop
    pkgs.adwaita-fonts
    pkgs.adw-gtk3
    pkgs.pywalfox-native
    pkgs.libreoffice
    pkgs.qbittorrent
    pkgs.retroshare
    pkgs.kdePackages.qqc2-desktop-style
    pkgs.meslo-lgs-nf
    pkgs.zsh-powerlevel10k
    pkgs.kdePackages.kate
    # pkgs.obsidian
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # ''
  };

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      syncthing-key = {
        file = ./secrets/syncthing-key.age;
      };
      syncthing-cert = {
        file = ./secrets/syncthing-cert.age;
      };
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableGitIntegration = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.name = "SergSel2006";
      user.email = "sergsel2006@mail.ru";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sergsel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    VISUAL = "kate -b";
    EDITOR = "nvim";
    XCURSOR_SIZE = "32";
    # QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.shell.enableShellIntegration = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./dotfiles;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "${config.home.homeDirectory}/.config/alacritty/themes/noctalia.toml" ];
      window.opacity = 0.6;
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  programs.neovim.enable = true;
  programs.lutris = {
    enable = true;
  };
  programs.keepassxc = {
    enable = true;
    autostart = true;
  };

  services.syncthing = {
    enable = true;
    cert = config.age.secrets.syncthing-cert.path;
    key = config.age.secrets.syncthing-key.path;
  };
  nixpkgs.config.allowUnfree = true;
}
