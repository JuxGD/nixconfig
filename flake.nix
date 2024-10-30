let
  systemarchitecturethingy = "x86_64-linux";
in
{
  description = "NixOS configuration";

  inputs = {
    stable = { url = "github:NixOS/nixpkgs/nixos-23.11"; };
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    staging = { url = "github:NixOS/nixpkgs/staging"; };
    musnix = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = systemarchitecturethingy;
        modules = [
          inputs.musnix.nixosModules.musnix
          ./configuration.nix
          ./packages.nix
          ./graphics.nix
          ./audio.nix
          ./fonts.nix
        ];
      specialArgs = { inherit inputs; system = systemarchitecturethingy};
      };
    };
  };
}
