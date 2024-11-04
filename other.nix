{ config, lib, pkgs, inputs, ... }:

{
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    forgejo.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}