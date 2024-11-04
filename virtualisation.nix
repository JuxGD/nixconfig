{ config, lib, pkgs, inputs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    podman.enable = true;

    virt-manager.enable = true;

    waydroid.enable = true;
  };
  
  programs = {
    libvirtd.enable = true;
    virt-manager.enable = true;
  };
}