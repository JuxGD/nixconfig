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
      setupPostgresqlDB = true;
      settings = {
        application-name = "welcome to fun land";
        bind-address = "127.0.0.1";
        port = 42067;
        protocol = "http";
        host = "127.0.0.1:42067";
      };
    };
  };
}