{ inputs, config, lib, pkgs, ... }:

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
