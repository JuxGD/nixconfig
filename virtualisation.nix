let
  # RTX 3070 Ti
  gpuIDs = [
    "10de:24a0" # Graphics
    "10de:228b" # Audio
  ];
in { config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";
  
  config = let cfg = config.vfio;
    in {
      virtualisation = {
        docker = {
          enable = true;
          rootless = {
            enable = true;
            setSocketVariable = true;
          };
        };

        podman.enable = true;

        libvirtd = {
          enable = true;
          qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        };

        spiceUSBRedirection.enable = true;

        waydroid.enable = true;
      };

      programs = {
        virt-manager.enable = true;
      };

      boot = {
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"

          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];

        kernelParams = [
          "amd_iommu=on"
        ] ++ lib.optional cfg.enable
          # Isolate the GPU
          ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };
      specialisation."VFIO".configuration = {
        system.nixos.tags = [ "with-vfio" ];
        vfio.enable = true;
      };
    };
}
