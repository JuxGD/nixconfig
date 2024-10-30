{ inputs, config, lib, pkgs, ... }:
let
  stable = inputs.stable.legacyPackages.${pkgs.system};
  master = inputs.master.legacyPackages.${pkgs.system};
  staging = inputs.master.legacyPackages.${pkgs.system};
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
    open-sans
    corefonts
    liberation_ttf
  ];

  fonts.enableDefaultPackages = true;
}
