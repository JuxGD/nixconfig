{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment = {
    variables = {
      MESA_DISK_CACHE_MULTI_FILE = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  services = {

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "amdgpu" ];
      displayManager.importedVariables = [ "MESA_DISK_CACHE_MULTI_FILE" ];
    };

    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs = {
    xwayland.enable = true;
    niri.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-browser-integration
    kdePackages.xdg-desktop-portal-kde
    kdePackages.kwayland
    kdePackages.kpipewire
    wayland-utils
  ];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = { enable = false; finegrained = false; };
      open = false;
      nvidiaSettings = true;

      prime = {
        amdgpuBusId = "PCI:116:0:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  xdg = {
    portal = {
      xdgOpenUsePortal = true;
      enable = true;
    };
  };
}
