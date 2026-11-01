# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./distcc.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.availableKernelModules = [
      "aesni_intel"
      "cryptd"
    ];
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" "noatime" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/var/log".options = [ "compress=zstd" "noatime" ];
  };

  networking.hostName = "Laptop-NixOS"; # Define your hostname.
  networking.nat = {
    enable = true;
    # Use "ve-*" when using nftables instead of iptables
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
  };

  services.resolved.enable = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;

  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tomsk";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.pantum-driver
      pkgs.cups-filters
      pkgs.cups-browsed
    ];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Main";
        location = "Общага";
        deviceUri = "dnssd://Pantum._ipp._tcp.local/?uuid=8c7c9f4b-98e5-4ef0-bce9-01f75c38753f";
        model = "Pantum/Pantum-M6500W-Series.ppd";
        ppdOptions = {
          PageSize = "A4";
          cupsIPPSupplies = "true";
        };
      }
    ];
    ensureDefaultPrinter = "Main";
  };

  age = {
    secrets = {
      i2pd-port = {
        file = secrets/i2pd-port.age;
      };
      i2pd-site = {
        file = secrets/i2pd-site.age;
        path = "/var/lib/i2pd/site.dat";
        mode = "644";
        owner = "nobody";
        group = "nogroup";
      };
      tor-site = {
        file = secrets/tor-site.age;
      };
      zerotier-id = {
        file = secrets/zt-identity-laptop.age;
        path = "/var/lib/zerotier-one/identity.secret";
        mode = "600";
        owner = "root";
        group = "root";
      };
      nix-key = {
        file = secrets/nix-key-laptop.age;
      };
    };
  };

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.udisks2.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.sergsel = {
    gid = 1000;
  };
  users.users.sergsel = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "gamemode"
      "libvirtd"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    description = "Сергей";
    group = "sergsel";
    initialHashedPassword = "$y$j9T$xFR61HbAAcOn6qFSpKPzZ/$IXRxZ8ohps4HUso8NLS72KqzZDIMMfa4VqOuoGr.R1D";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqrXwzK9/t9aGQVer8uHXUwLYhN2DQIUXUZ2QcCEPaLpsZweJCNwk2ILymtDk7YSGO+/4Y+NLWIfU9uSX0ns46c63AX6WZX+JW/c5Dd1kilsKkyYy5CxxMd3UX8AmQsQRXKldkd/TojOa4Ik6KqZpwlTgafgac7mlxh+kMDCyLF0yQjvZH0a+5Yvx5KzLTWYucAKzTUL3y2atJMubz8VXLX6NUhdCl1reJXxO33tSY89woGKMnKi6LWMqLgvanAmpsXnpcQoYkewrqt4ufioG8Lq+qNOgvvvYbRNI8/Rr67uql1GxMEkB99AamcAG9AfoN8BawIDzkvyhSFqGvIlG5T6UDm0Mw8SA549Q9ngXKyTvmRGCIsVFeyiyCWeijzMhBeXq9zi3XJ2PZ5iasVWeOEIh7UDHZbNpXL4b7YBKX7pAnrnUmzxZ+vm6f7Rgcs0argxneFzgFSCwz2+lNc/u8zuiO7jw2XkYhcXH/9TnzSBmpObtvTsIqUmNBVYzme2k="
    ];
    #   packages = with pkgs; [
    #     tree
    #   ];
  };
  services.tuned.enable = true;
  services.upower.enable = true;
  services.bpftune.enable = true;
  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.sbctl
    pkgs.gpu-screen-recorder
    pkgs.virtio-win
    pkgs.virtiofsd
    pkgs.apparmor-parser
  ];

  services.displayManager.enable = true;

  programs.niri.enable = true;
  services.iio-niri.enable = true;
  programs.niri.useNautilus = false;
  services.gnome.gnome-keyring.enable = false; # secret service
  services.displayManager.ly.enable = true;
#  services.displayManager.noctalia-greeter = {
#    enable = true;
#    cursorTheme.name = "Bibata_Ghost";
#    cursorTheme.package = pkgs.bibata-cursors-translucent;
#  };

  programs.zsh.enable = true;
  programs.gamemode = {
    enable = true;
    settings.general.renice = 7;
    settings.general.softrealtime = "on";
  };
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  security.polkit.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # services.btrfs.autoScrub.enable = true;

  services.beesd.filesystems = {
    root = {
      spec = "UUID=45c9b91f-69f6-4d79-956c-02e7c6bba415";
      hashTableSizeMB = 512;
      verbosity = "crit";
      extraOptions = [
        "--loadavg-target"
        "4.0"
      ];
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = false;
    settings = {
      UseBridges = true;
      ClientTransportPlugin = "webtunnel exec ${pkgs.webtunnel}/bin/client";
      Bridge = [
        "webtunnel [2001:db8:61d8:dd06:ee48:5658:1005:8c1a]:443 ED7E43FDFA82588D3E01B713F649C5C00C452B0A url=https://mdapi.ch/api/v1/proxy/U84is7V9U8rB0ZgnWKfs65lmwsvprN9x ver=0.0.5"
        "webtunnel [2001:db8:b25f:7b5c:ea:7689:d15e:3389]:443 669F835F5358D33A79DDDD559A3A167B104FF3BC url=https://dsl.one.pl/X7yJZdFkZTGdQkMMclV4qdVz ver=0.0.5"
        "webtunnel [2001:db8:dee9:5852:b4dc:7e14:21bd:c99b]:443 8ADF1761FA735FDD763781BB94A16EAB64A1CF6C url=https://app01.oneclickhost.eu/WJSgXJRlNnMStkuLZygVJ7lo ver=0.0.6"
        "webtunnel [2001:db8:d0f2:6cd4:8630:8185:18d2:a5c]:443 5A94C0CDB0ED58681BDAA8FDBC53F5C9E32058F8 url=https://beefstrognoff.com/xRiEjTMRdkc9l7vrlASBmOus ver=0.0.4"
        "webtunnel [2001:db8:11d3:d5e7:2939:8453:7baf:868f]:443 531640559965FB7501EB5C006018F61D1E9FA1BB url=https://cdn-34.triplebit.dev/Aec3euCh4ux3deij ver=0.0.2"
      ];
      HTTPTunnelPort = [ 8118 ];
    };
    relay.onionServices = {
      "homesite" = {
        map = [
          {
            port = 80;
            target = {
              addr = "192.168.100.11";
              port = 8080;
            };
          }
        ];
        version = 3;
        secretKey = config.age.secrets.tor-site.path;
      };
    };
  };
  services.i2pd = {
    enable = true;
    port = 49723;
    inTunnels = {
      "site" = {
        type = "http";
        address = "192.168.100.11";
        port = 8080;
        keys = "site.dat";
      };
    };
  };
  systemd.services.i2pd.serviceConfig.LimitNOFILE = 4096; #i2pd has a ton of profiles to open on normal install... I guess this is needed...

  services.udev = {
    enable = true;
    extraRules = ''
      KERNEL=="uinput", GROUP="input"
      KERNEL=="event*", NAME="input/%k", MODE="660", GROUP="input"
      SUBSYSTEM=="powercap", KERNEL=="intel-rapl:0", RUN+="${pkgs.coreutils}/bin/chgrp wheel /sys/%p/energy_uj'", RUN+="${pkgs.coreutils}/bin/chmod g+r /sys/%p/energy_uj"
    '';
    extraHwdb = ''
      sensor:modalias:acpi:MDA6655*:*
        ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, 1
    '';
  };

  services.evremap = {
    enable = true;
    settings = {
      device_name = "AT Translated Set 2 keyboard";
      remap = [
        {
          input = [
            "KEY_LEFTALT"
            "KEY_LEFT"
          ];
          output = [
            "KEY_END"
          ];
        }
      ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings = {
    substituters = [ "https://mirror.yandex.ru/nixos" ];
    trusted-public-keys = [ "" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    secret-key-files = [ config.age.secrets.nix-key.path ];
  };
  nixpkgs.config.allowUnfree = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "c7c8172af1d8956c"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    sensor = {
      iio.enable = true;
    };
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [
      "qwen3.5:4b"
      "qwen2.5-coder:7b"
    ];
    environmentVariables.OLLAMA_IGPU_ENABLE = "1";
    environmentVariables.OLLAMA_CONTEXT_LENGTH = "131072";
    environmentVariables.HTTPS_PROXY = "http://127.0.0.1:8118";
    environmentVariables.https_proxy = "http://127.0.0.1:8118";
  };

  containers.homesite = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    config = { config, pkgs, lib, ... }: {

      services.darkhttpd = {
        enable = true;
        rootDir = ./homesite;
        port = 8080;
        address = "::";
      };

      networking = {
        firewall.allowedTCPPorts = [ 8080 ];

        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;

      system.stateVersion = "26.05";
    };
  };
}
