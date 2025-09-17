{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};

  juxgd = inputs.personal-nur.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = [
    juxgd.noriskclient-launcher
  ];

  nix.settings = {
    substituters = [ "https://juxgd.cachix.org" ];
    trusted-public-keys = [ "juxgd.cachix.org-1:/Scj3g00eOCJAX3yxM9q6a3LREo/ppQQOqxtEavr+t4=" ];
  };

  services = {
    forgejo.enable = true;
    gnome.gnome-keyring.enable = true;

    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    open-webui = {
      openFirewall = true;
      enable = true;
      package = stable.open-webui;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "False";
      };
    };
  };

  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

}
