{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  nixpkgs.overlays = [ inputs.nur.overlays.default ];
 
  programs = {
    nh = {
      enable = true;
    };
  };

  services = {
    searx = {
      enable = true;
      settings = {
        server.base_url = "localhost";
        server.port = 1337;
        server.bind_address = "localhost";
        server.secret_key = "N0-t-h3_S4m3";
      };
    };

    flatpak.enable = true;
  };

  environment.systemPackages = with pkgs; [
    floorp
    kitty
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
    f3
    caffeine-ng
    qbittorrent
    nur.repos.lonerOrz.xdman7
  ];
}
