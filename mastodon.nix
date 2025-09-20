{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    mastodon
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "jak@e.email";
  };
  services.mastodon = {
    enable = true;
    webPort = 6700;
    localDomain = "127.0.0.1:42067"; # Replace with your own domain
    configureNginx = true;
    smtp.fromAddress = "jak@e.email"; # Email address used by Mastodon to send emails, replace with your own
    streamingProcesses = 7; # Number of processes used. It is recommended to set to the number of CPU cores minus one
    extraConfig.SINGLE_USER_MODE = "false";
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}