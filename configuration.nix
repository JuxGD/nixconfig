# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, lib, pkgs, unstable, staging, ... }:

let
  doubleclickingtext = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=0
  '';
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Boot loader
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        devices = [ "nodev" ];
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };
    };
    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
    '';
  };

  networking.hostName = "jpc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      j2 = {
        isNormalUser = true;
        description = "j2";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" "jackaudio" "audio" ];
      };

      j = {
        isNormalUser = true;
        description = "j";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" "jackaudio" "audio" ];
      };
    };
  };

  security.polkit.enable = true;

  environment.extraOutputsToInstall = [ "dev" ];
  environment.etc."libinput/local-overrides.quirks".text = doubleclickingtext;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.waydroid = {
    enable = true;
  };

  programs.kdeconnect.enable = true;
  programs.light.enable = true;
  programs.gamemode.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    xorg.libxcb
    libsForQt5.full
    libgcc
    glib
    libvlc
    cudaPackages.libcublas
    libsForQt5.qt5.qtx11extras
    alsa-lib
    libsoup_3
    libevdev
    linuxHeaders
    libusb1
    gtk3
    pango
    cairo
    harfbuzz
    atk
    gdk-pixbuf
    libepoxy
    fontconfig
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  fonts.fontconfig.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  services = {

    # Configure keymap in X11
    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    flatpak.enable = true;

    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    forgejo.enable = true;

    open-webui = {
      enable = true;
      package = staging.open-webui;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "True";
      };
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.gnome.gnome-keyring.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.allowed-users = [ "@wheel" "j2" "j" ];
  nix.settings.auto-optimise-store = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.\nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
