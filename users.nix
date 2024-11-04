{ config, lib, pkgs, inputs, ... }:

{
  users = {
    users = {

      j = {
        isNormalUser = true;
        description = "j";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" "jackaudio" "audio" ];
      };

      j2 = {
        isNormalUser = true;
        description = "j2";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" "jackaudio" "audio" ];
      };

    };
  };
}