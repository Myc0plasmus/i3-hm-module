
{ pkgs }:

pkgs.writeShellScriptBin "resetWallpaperLock" ''
  ${pkgs.feh}/bin/feh --bg-scale $HOME/.config/user-wallpapers/wp12329536-nixos-wallpapers.png
  ${pkgs.betterlockscreen}/bin/betterlockscreen -u $HOME/.config/user-wallpapers/lockscreen.png 
''
