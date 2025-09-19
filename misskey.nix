{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  services = {
    misskey = {
      enable = true;
      settings = {
        url = "http://127.0.0.1:42067";
        port = 42067;
      }
    };
  };
}