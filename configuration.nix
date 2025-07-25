{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  time.timeZone = "America/Santiago";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  security.polkit.enable = true;

  environment = {
    extraOutputsToInstall = [ "dev" ];
  };

  programs = {
    kdeconnect.enable = true;
    light.enable = true;
    zsh.enable = true;
    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "@wheel" "j2" "j" ];
    auto-optimise-store = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
