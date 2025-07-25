{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
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
          pkgs.vistafonts
        ]);
      });

      gamescopeSession.enable = true;

    };
  };
}
