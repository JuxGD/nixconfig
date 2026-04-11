{ config, lib, pkgs, inputs, nix-cachyos-kernel, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.default
  ];

  boot = {
    supportedFilesystems = [ "ntfs" "ext4" ];
    loader = {
      systemd-boot.enable = false;
      
      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        devices = [ "/dev/nvme0n1" ];
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };

      limine = {
        biosDevice = "/dev/nvme0n1";
	enable = false;
	enableEditor = true;
	efiSupport = true;
	biosSupport = true;
      };
    };
    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
    '';

    kernelPackages = pkgs.linux-cachyos-bore;
  };
}
