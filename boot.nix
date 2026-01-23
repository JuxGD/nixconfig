{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  boot = {
    supportedFilesystems = [ "ntfs" "ext4" ];
    loader = {
      systemd-boot.enable = false;
      
      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        devices = [ "/dev/nvme0n1" ];
        enable = false;
        efiSupport = true;
        useOSProber = true;
      };

      limine = {
        biosDevice = "/dev/nvme0n1";
	enable = true;
	enableEditor = true;
	efiSupport = true;
      };
    };
    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
    '';

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
