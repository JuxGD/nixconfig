{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  nixpkgs.overlays = [ inputs.niri-package.overlays.default ];
  
  environment = {
    variables = {
      MESA_DISK_CACHE_MULTI_FILE = "1";
      NIXOS_OZONE_WL = "1";
    };

    etc."environment".text = ''
      KWIN_DRM_NO_AMS=1
    '';

    systemPackages = with pkgs; [
      xwayland-satellite
      wayland-utils
      grim
      slurp
      wl-clipboard
      mako
      walker
      elephant
      wlogout
      swww
      swaylock
      swayidle
      waybar
      btop
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
      enableQt5Integration = true;
    };
  };

  programs = {
    xwayland.enable = true;
    
    niri = {
      package = pkgs.niri-package;
    };
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    gnome-keyring
  ];
}
