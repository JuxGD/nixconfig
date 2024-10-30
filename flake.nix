{
  description = "NixOS configuration";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/24.05";
    master.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    staging.url = "github:NixOS/nixpkgs/staging";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.musnix.nixosModules.musnix
          ./configuration.nix
          ./packages.nix
          ./graphics.nix
          ./audio.nix
          ./fonts.nix
        ];
      };
    };
  };
}
