{ inputs, config, lib, pkgs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system}; 

  getOBSThingySourcethingID = pkgs.stdenv.mkDerivation {
    name = "get-obs-thingy-sourcething-id";
    src = null;

    buildCommand = ''
      echo #!/run/current-system/sw/bin/bash > $out
      echo "${pkgs.wireplumber}/bin/wpctl status | grep -A 5 Sources | grep obs | cut -c 1-20 | grep -o '[0-9]''\\+' >> /home/j/Scripts/obs-thingy-sourcething-id" > $out
      chmod +x $out
    '';
  }
in
{
  environment.systemPackages = with pkgs; [
    mpd
    carla
    bespokesynth
    yabridge
    yabridgectl
    lsp-plugins
    chow-kick
    chow-phaser
    chow-centaur
    chow-tape-model
    adlplug
    odin2
    padthv1
    geonkick
    vcv-rack
    helm
    zynaddsubfx
    drumkv1
    surge-XT
    fluidsynth
    rakarrack
    rkrlv2
    easyeffects
    bslizr
    delayarchitect
    plugdata
    cardinal
    distrho-ports
    vital
    jamesdsp
    patchage
    pulseaudio
];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    soundcardPciId = "74:00.6";
  };
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire-pulse = {
        "obs-thingy" = {
	  "pulse.cmd" = [
	    {
	      cmd = "load-module";
	      args = "module-null-sink media.class=Audio/Sink sink_name=obs-thingy channel_map=stereo";
	    }
	    {
	      cmd = "load-module";
	      args = "module-null-sink media.class=Audio/Source/Virtual sink_name=obs-thingy-sourcething channel_map=front-left,front-right";
	    }
	  ];
	};
      };

      extraConfig.pipewire = {
	"obs-thingy" = {
	  context.exec = [
	    {
	      path = "pw-link";
	      args = "alsa_input.pci-0000_74_00.6.analog-stereo:capture_FL obs-thingy-sourcething:input_FL"; 
	    }
	    {
	      path = "pw-link";
	      args = "alsa_input.pci-0000_74_00.6.analog-stereo:capture_FR obs-thingy-sourcething:input_FR";
	    }
	  ];
	};
      };
      # use the example session manager (no others are packaged yet so this is enabled by defau>
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  systemd.services.get-obs-thingy-sourcething-id = {
    description = "Get the ID for the `obs-thingy-sourcething` PipeWire object and print it to a file";
    serviceConfig.ExecStart = "${pkgs.getOBSThingySourcethingID}/bin/get-obs-thingy-sourcething-id";
    wantedBy = [ "default.target" ];
  };
}
