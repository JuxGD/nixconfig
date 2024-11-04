{ config, lib, pkgs, inputs, ... }:

{
  boot = {
    loader = {
      supportedFilesystems = [ "ntfs" ];
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