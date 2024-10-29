<<<<<<< HEAD
{ pkgs, lib, config, ... }:

let
  stable = import <nixos-stable/nixpkgs> { config = config.nixpkgs.config; };
=======
{ inputs, pkgs, lib, config, ... }:

let
  doubleclicking = pkgs.writeText "doubleclicking" ''
    [peepeepoopoo]
    MatchName=*
    ModelBouncingKeys=1
  '';
>>>>>>> 32179d7 (wooo yea woo)
in
{
  environment.systemPackages = with pkgs; [
    floorp
<<<<<<< HEAD
    libusb
    libsForQt5.qtwayland
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbproto
    cudaPackages.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cudnn
    cudaPackages.libcublas
    cudaPackages.cutensor
    libsForQt5.full
    libsForQt5.qt5.qtx11extras
    distrobox
    cmake
    (pkgs.python3.override {
      bluezSupport = true;
    })
=======
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
>>>>>>> 32179d7 (wooo yea woo)
    android-tools
    grim
    slurp
    wl-clipboard
    mako
    gnumake
<<<<<<< HEAD
    libvlc
=======
>>>>>>> 32179d7 (wooo yea woo)
    onlyoffice-bin_latest
    nodejs
    wineWowPackages.staging
    winetricks
<<<<<<< HEAD
    libgcc
=======
>>>>>>> 32179d7 (wooo yea woo)
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
<<<<<<< HEAD
=======
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
>>>>>>> 32179d7 (wooo yea woo)
  ];
}
