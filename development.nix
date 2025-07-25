{ pkgs, lib, config, inputs, ... }:

let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.staging.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    vscode-fhs
    cudaPackages.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cudnn
    cudaPackages.cutensor
    cmake
    (python3.override {
      bluezSupport = true;
    })
    android-tools
    rustup
    haxe
    neko
    mono
    nodejs
    nodePackages.pnpm
    conda
    git
    linuxHeaders
    pyenv
  ];
}
