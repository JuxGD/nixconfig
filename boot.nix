{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  boot = {
    kernelPackages = pkgs.linuxKenrel.kernels.linux_6_12;
    supportedFilesystems = [ "ntfs" ];
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
}
