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
        server.port = 1337;
        server.bind_address = "127.0.0.1";
        server.secret_key = "secretkeylol";
      };
    };

    sharkey = {
      enable = true;
    };

    flatpak.enable = true;
  };

  environment.systemPackages = with pkgs; [
    floorp-bin
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
    thunderbird
    libinput
    onlyoffice-bin_latest
    f3
    caffeine-ng
    qbittorrent
    nur.repos.lonerOrz.xdman7
  ];
}
