{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  networking = {
    hostName = "jpc";
    networkmanager = {
      enable = true;
    };

    firewall = {
      allowedTCPPorts = [ 8080 ];
      trustedInterfaces = [ "virbr0" ];
      # firewall.allowedUDPPorts = [ ... ]; # Open ports in the firewall.
      # Or disable the firewall altogether.
      # firewall.enable = false;
    };
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
