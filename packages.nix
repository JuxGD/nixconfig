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
    onlyoffice-bin_latest
    nodejs
    wineWowPackages.staging
    winetricks
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
    nh
    tk
    egl-wayland
    git
    unzip
    cdrkit
    fuse3
    openssl
    rustup
    ryujinx
    linuxHeaders
    python310
    scrcpy
    tmux
    inotify-tools
    wget
    thunderbird
    protonup-qt
    libinput
    tofi
    waybar
    swww
    qtscrcpy
    keepassxc
    stable.carla
    alacritty
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    })
  ];
}
