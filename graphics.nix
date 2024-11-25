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

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = { enable = false; finegrained = false; };
      open = true;
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
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      enable = true;
      config.common.default = "gtk";
    };
  };
}
