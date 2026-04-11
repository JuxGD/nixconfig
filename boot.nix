{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};

  nix-cachyos-kernel = inputs.nix-cachyos-kernel;
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
        device = "nodev";
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

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;

    kernelModules = [ "ntsync" ];

   };

  services.scx = {
    enable = true;
    scheduler = "scx_cosmos";
    extraArgs = [
      "-m performance"
      "-c 0"
      "-p 0"
      "-w"
    ];
  };
}

