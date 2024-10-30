{
  description = "NixOS configuration";

  inputs = {
    stable.url = "nixpkgs/24.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    staging.url = "nixpkgs/staging";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs unstable; };
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
