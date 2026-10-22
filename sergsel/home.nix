{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../common
    modules/niri
    modules/xdg.nix
    # modules/driftwm/main.nix
  ];
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

  home.packages = [
    pkgs.yandex-music
    (pkgs.prismlauncher.override {
      jdks = [
        pkgs.temurin-jre-bin-17
        pkgs.temurin-jre-bin-21
        pkgs.temurin-jre-bin-27
        pkgs.graalvmPackages.graalvm-ce
      ];
    })
    pkgs.amberol
    pkgs.lxqt.pcmanfm-qt
    pkgs.lxqt.lxqt-archiver
    pkgs.telegram-desktop
    pkgs.pywalfox-native
    pkgs.libreoffice
    pkgs.qbittorrent
    pkgs.retroshare
    pkgs.kdePackages.qqc2-desktop-style
    pkgs.meslo-lgs-nf
    pkgs.zsh-powerlevel10k
    pkgs.kdePackages.kate
    pkgs.obsidian
    pkgs.krita
    pkgs.qiv
    pkgs.easyeffects
    pkgs.vkbasalt
    pkgs.lxqt.lxqt-openssh-askpass
    pkgs.udiskie
    pkgs.gvfs
    pkgs.ffmpegthumbnailer
    pkgs.retroarch-full
    pkgs.nix-search-tv
    pkgs.ffmpeg
    pkgs.squeekboard
    pkgs.mission-center
    pkgs.zoom-us
  ];

  home.file = { };

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
  programs.git = {
    settings = {
      gpg.ssh.allowedSignersFile = "~/.config/git/allowed-signers";
    };
    signing.format = "ssh";
    signing.key = "${config.home.homeDirectory}/.ssh/ssh_keys/SSH";
    signing.signByDefault = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "noctalia";
    };
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    icons = "auto";
  };

  home.sessionVariables = {
    VISUAL = "kate -b";
    EDITOR = "nvim";
    SSH_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    TERMINAL = "alacritty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.65;
    };
  };
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  programs.lutris = {
    enable = true;
  };
  programs.keepassxc = {
    enable = true;
    autostart = true;
  };

  services.udiskie = {
    enable = true;
    tray = "never";
    notify = false;
  };

  services.syncthing = {
    enable = true;
    cert = config.age.secrets.syncthing-cert.path;
    key = config.age.secrets.syncthing-key.path;
  };
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
        };
      }
    );
  };
  nixpkgs.config.allowUnfree = true;
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = with lib.hm.gvariant; [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "ru"])];
    };
  };
}
