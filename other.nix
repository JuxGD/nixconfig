{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
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