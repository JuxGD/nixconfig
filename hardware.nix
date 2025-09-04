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

    power-profiles-daemon.enable = false;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
	CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

	CPU_MIN_PERF_ON_AC = 0;
	CPU_MAX_PERF_ON_AC = 100;
	CPU_MIN_PERF_ON_BAT = 0;
	CPU_MAX_PERF_ON_BAT = 20;

	START_CHARGE_THRESH_BAT1 = 15;
        STOP_CHARGE_THRESH_BAT1 = 80;
      };
    };
  };
}
