{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  services.qbittorrent.enable = true;

  environment.systemPackages = with pkgs ; [
    floorp
    alacritty
    tmux
    inotify-tools
    scrcpy
    qtscrcpy
    unzip
    ffmpeg
    wineWowPackages.staging
    winetricks
    fuse3
    unzip
    cdrkit
    wget
    keepassxc
    temurin-bin
    temurin-bin-8
    temurin-bin-17
    thunderbird
    libinput
    onlyoffice-bin_latest
    nh
    f3
  ];
}
