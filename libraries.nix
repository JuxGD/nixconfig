{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.master.legacyPackages.${pkgs.system};
in
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    xorg.libxcb
    libsForQt5.full
    libgcc
    glib
    libvlc
    cudaPackages.libcublas
    libsForQt5.qt5.qtx11extras
    alsa-lib
    libsoup_3
    libevdev
    linuxHeaders
    libusb1
    gtk3
    pango
    cairo
    harfbuzz
    atk
    gdk-pixbuf
    libepoxy
    fontconfig
    portaudio
  ];
}
