{ config, lib, pkgs, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    acl
  ];

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
