{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment = {
    variables = {
      MESA_DISK_CACHE_MULTI_FILE = "1";
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [
      xwayland-satellite
      wayland-utils
      grim
      slurp
      wl-clipboard
      mako
      anyrun
      wlogout
      swaybg
      swaylock
      swayidle
    ];
  };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };

    desktopManager.plasma6 = {
      enable = true;
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs = {
    xwayland.enable = true;
    niri.enable = true;
    waybar.enable = true;
  };
}
