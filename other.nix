{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  nix.settings.substituters = pkgs.lib.mkForce [ "https://cache.nixos.org" ];

  services = {
    forgejo.enable = true;
    gnome.gnome-keyring.enable = true;
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
