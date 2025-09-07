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

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    # modules
    musnix.url = "github:musnix/musnix/master";

    nur = {
      url = "github:nix-community/NUR/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, nix-flatpak, lix-module, lix, nixgl, ... }@inputs:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ nixgl.overlay ];
    };
  in
  rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
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
