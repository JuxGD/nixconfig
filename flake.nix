{
  description = "NixOS configuration";

  inputs = {
    stable.url = "nixpkgs/24.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    staging.url = "nixpkgs/staging";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, stable, nixpkgs, staging, ... }@inputs:
  let
    overlay = final: prev: let
      stablePkgs = import stable { inherit (prev) system; config.allowUnfree = true; };
      stagingPkgs = import staging { inherit (prev) system; config.allowUnfree = true; };
    in {
      stable = stablePkgs;
      zhdStable = stablePkgs.zfsStable;
      staging = stagingPkgs;
      zhdStaging = stagingPkgs.zfsStaging;
    };

    overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
  in
  rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.musnix.nixosModules.musnix
          overlayModule
          ./configuration.nix
          ./packages.nix
          ./graphics.nix
          ./audio.nix
          ./fonts.nix
          { stable, staging, ... }: { }
        ];
        specialArgs.channels = { inherit nixpkgs stable staging; };
      };
    };
  };
}
