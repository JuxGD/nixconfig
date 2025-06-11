\let
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
  boot.loader.grub.extraConfig = "amd_iommu=on";
  boot.kernelParams = [ "amd_iommu=on" "vfio_pci.ids=10de:24a0,10de:228b" ];
  boot.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
}
