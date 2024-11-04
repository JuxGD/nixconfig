{ config, lib, pkgs, inputs, ...}:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  environment = {
    etc = {
      "libinput/local-overrides.quirks".text = ''
        [Never Debounce]
        MatchUdevType=mouse
        ModelBouncingKeys=1
      '';
    };
  };

  services = {
    printing.enable = true;
    libinput.enable = true;
    forgejo.enable = true;
    gnome.gnome-keyring.enable = true;

    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };
}