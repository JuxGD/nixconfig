{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
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
    pipreqs
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
    rustup
    ryujinx
    linuxHeaders
    python310
    scrcpy
    espeak
    tmux
    inotify-tools
    wget
    thunderbird
    protonup-qt
    direnv
    libinput
  ];
}
