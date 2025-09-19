{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  services = {
    gotosocial = {
      enable = true;
      settings = {
        application-name = "gotosocial";
        bind-address = "127.0.0.1";
        db-address = "/var/lib/gotosocial/database.sqlite";
        db-type = "sqlite";
        port = 42067;
        protocol = "http";
        storage-local-base-path = "/var/lib/gotosocial/storage";
      }
    };
  };
}