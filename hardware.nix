{ config, lib, pkgs, inputs, ...}:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    nvidia-container-toolkit.enable = true;
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

    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };

    tlp = {
      enable = true;
      settings = {
        STOP_CHARGE_THRESH_BAT1 = 80;
      };
    };
  };
}
