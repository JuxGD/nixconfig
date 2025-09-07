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

    systemPackages = with pkgs; [
      tk
      egl-wayland
      nixgl.nixGLDefault
      nixgl.nixGLNvidia
      nixgl.nixGLNvidiaBumblebee
      nixgl.nixGLIntel
      nixgl.nixVulkanNvidia
      nixgl.nixVulkanIntel
    ];
  };

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  services = {

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "amdgpu" ];
      displayManager.importedVariables = [ "MESA_DISK_CACHE_MULTI_FILE" ];
    };
  };

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
}
