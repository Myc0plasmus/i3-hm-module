{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.killall
    pkgs.font-awesome
    pkgs.papirus-icon-theme
  ];
  services.polybar = {
    enable = true;
    # script = "$HOME/.local/bin/launchPolybar &";
    script = "echo useless";
    config = ../dotfiles/polybar/config.ini;
  };
}
