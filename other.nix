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

    open-webui = {
      enable = true;
      package = staging.open-webui;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "False";
      };
    };

    forgejo.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}