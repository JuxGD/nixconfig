{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  config.boot.loader.grub.extraConfig = "amd_iommu=on";
  config.boot.kernelParams = [ "amd_iommu=on" "vfio_pci.ids=10de:24a0,10de:228b" ];
  config.boot.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
}
