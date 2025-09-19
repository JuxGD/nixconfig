{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  services = {
    akkoma = {
      enable = true;
      config = {
        ":pleroma" = {
          ":instance" = {
            name = "welcome to funland";
            description = "funland is a land that is fun";
            email = "jak@e.email";
            registration_open = true;
          };

          "Pleroma.Web.Endpoint" = {
            url = {
              host = "127.0.0.1";
              port = 6700;
              scheme = "http";
            };
            port = "42067";
            ip = [127 0 0 1];
          };

          "Pleroma.Upload" = {
            base_url = "127.0.0.1";
          };
        };
      };
    };
  };
}