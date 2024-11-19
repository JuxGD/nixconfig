{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  services = {
    
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "amdgpu" ];
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
    hyprland.enable = true;
  };

  hardware = {

    graphics = {
      enable = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      enable = true;
      config.common.default = "gtk";
    };
  };
}
