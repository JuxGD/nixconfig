{ inputs, pkgs, lib, config, ... }:

let
  doubleclicking = pkgs.writeText "doubleclicking" ''
    [peepeepoopoo]
    MatchName=*
    ModelBouncingKeys=1
  '';
in
{
  environment.systemPackages = with pkgs; [
    floorp
    cudaPackages.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cudnn
    cudaPackages.cutensor
    distrobox
    cmake
    (pkgs.python312.override {
      bluezSupport = true;
    })
    python312Packages.huggingface-hub
    android-tools
    grim
    slurp
    wl-clipboard
    mako
    gnumake
    onlyoffice-bin_latest
    nodejs
    wineWowPackages.staging
    winetricks
    gcc
    ffmpeg
    mono
    nodePackages.pnpm
    conda
    acl
    temurin-bin
    temurin-bin-8
    temurin-bin-17
    haxe
    neko
    hashlink
    nh
    tk
    egl-wayland
    looking-glass-client
    git
    unzip
    cdrkit
    fuse3
    openssl
    pkg-config
    vital
    carla
    rustup
    ryujinx
    linuxHeaders
    python310
    yabridge
    yabridgectl
    scrcpy
    espeak
    tmux
    inotify-tools
    wget
    fh
    (pkgs.runCommand "doubleclicking" {} ''
      mkdir -p /etc/libinput/localoverrides.quirks
      ln -s ${doubleclicking} /etc/libinput/localoverrides.quirks
    '')
  ];
}
