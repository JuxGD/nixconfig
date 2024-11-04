{ config, lib, pkgs, inputs, ... }:

{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}