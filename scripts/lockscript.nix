{ pkgs }:

pkgs.writeShellScriptBin "lockscript" ''
  # Lock screen displaying this image.
  # i3lock -i /etc/nixos/dotfiles/i3/lockscreen_3440x1440.png
  ${pkgs.betterlockscreen}/bin/betterlockscreen -l --off 5
  # dm-tool lock


  # Turn the screen off after a delay.
  # sleep 300 && pgrep i3lock && xset dpms force off
''
