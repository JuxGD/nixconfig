{ inputs, config, lib, pkgs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
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
    stable.jamesdsp
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
      # use the example session manager (no others are packaged yet so this is enabled by defau>
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}
