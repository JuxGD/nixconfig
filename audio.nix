{ inputs, config, lib, pkgs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    carla
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
    magnetophonDSP.VoiceOfFaust
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
    jamesdsp
    delayarchitect
    plugdata
    cardinal
    distrho-ports
    vital
  ];

  musnix.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraConfig = "load-module module-null-sink sink_name=VAC\nupdate-sink-proplist STREAM device.description=Virtual_Output\nupdate-source-proplist STREAM.monitor device.description=VirtualInput\npacmd load-module module-loopback sink=VAC source=alsa_input.pci-0000_74_00.6.analog-stereo latency_msec=1";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by defau>
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  nixpkgs.config.pulseaudio = true;
}
