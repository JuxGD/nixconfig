{ config, lib, pkgs, ... }:

{
  imports =
    [
      /home/j2/musnix
    ];
  
  musnix.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
}
