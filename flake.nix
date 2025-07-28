{
  # Jux's NixOS configuration
  description = "NixOS configuration";

  inputs = {
    # nixpkgs branches
    stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    master.url = "github:NixOS/nixpkgs/master"; 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable branch is default
    staging.url = "github:NixOS/nixpkgs/staging";

    # use lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # modules
    musnix.url = "github:musnix/musnix/master";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module,  ... }@inputs: rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.musnix.nixosModules.musnix
          lix-module.nixosModules.default
          ./audio.nix
          ./boot.nix
          ./configuration.nix
          ./desktop.nix
          ./development.nix
          ./fonts.nix
          ./gaming.nix
          ./graphics.nix
          ./hardware.nix
          ./libraries.nix
          ./networking.nix
          ./other.nix
          ./tools.nix
          ./users.nix
          ./virtualisation.nix
        ];
      };
    };
  };
}
