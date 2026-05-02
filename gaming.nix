{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};

  proton-flake = inputs.proton-flake;
in
{
  programs = {
    gamemode.enable = true;
    gamescope.enable = true;

    steam = {
      enable = true;
      package = (pkgs.steam.override {
        extraPkgs = (pkgs: [
          pkgs.corefonts
          pkgs.vista-fonts
        ]);
      });

      extraCompatPackages = [
        proton-flake.packages.${pkgs.stdenv.hostPlatform.system}.ge-proton
        proton-flake.packages.${pkgs.stdenv.hostPlatform.system}.cachyos-proton
      ];

      gamescopeSession.enable = true;

    };
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
