{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  options.vfio.enable = with lib;
    mkEnableOption "Configure machine for VFIO";

  config = let cfg = config.vfio; 
  in {

    programs.virt-manager.enable = true;

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

    environment.systemPackages = with pkgs; [
      distrobox
    ];

    specialisation."VFIO".configuration = {
      system.nixos.tags = [ "with-vfio" ];
      vfio.enable = true;

      boot.loader.grub.extraConfig = "amd_iommu=on";
      boot.kernelParams = [ "amd_iommu=on" "vfio_pci.ids=10de:24a0,10de:228b" ];
      boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
    };
  };
}
