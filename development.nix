{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    vscode-fhs
    stable.cudaPackages.cudatoolkit
    stable.cudaPackages.cuda_cudart
    stable.cudaPackages.cudnn
    stable.cudaPackages.libcutensor
    cmake
    (python3.override {
        bluezSupport = true;
    })
    temurin-bin
    temurin-bin-8
    temurin-bin-17
    android-tools
    mono
    pnpm
    conda
    git
    linuxHeaders
  ];
}
