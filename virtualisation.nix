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

    podman = {
      enable = true;
      dockerCompat = true;
    };

    libvirtd.enable = true;

    waydroid.enable = true;
  };
  
  programs = {
    virt-manager.enable = true;
  };
}