<<<<<<< HEAD
{ config, lib, pkgs, ... }:
=======
{ inputs, config, lib, pkgs, ... }:
>>>>>>> 32179d7 (wooo yea woo)

{
  fonts.packages = with pkgs; [
    noto-fonts
<<<<<<< HEAD
    noto-fonts-cjk
=======
    noto-fonts-cjk-sans
>>>>>>> 32179d7 (wooo yea woo)
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
