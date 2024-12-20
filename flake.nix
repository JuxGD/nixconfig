{
  # Jux's NixOS configuration
  description = "NixOS configuration";

  inputs = {
    # nixpkgs branches
    stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    master.url = "github:NixOS/nixpkgs/master"; 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable branch is default
    staging.url = "github:NixOS/nixpkgs/staging";

    # modules
    musnix.url = "github:musnix/musnix/master";

    # program flakes
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@inputs: rec {
    nixosConfigurations = {
      jpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.musnix.nixosModules.musnix
          ./configuration.nix
          ./audio.nix
          ./boot.nix
          ./fonts.nix
          ./gaming.nix
          ./graphics.nix
          ./hardware.nix
          ./libraries.nix
          ./networking.nix
          ./packages.nix
          ./users.nix
          ./virtualisation.nix
          ./other.nix
        ];
      };
    };
  };
}
