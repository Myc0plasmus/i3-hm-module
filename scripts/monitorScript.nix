{ pkgs }:

pkgs.writeShellScriptBin "monitorScript" ''
  if ${pkgs.xorg.xrandr}/bin/xrandr --query | grep "HDMI-1 connected"
  then
    if ${pkgs.hwinfo}/bin/hwinfo --monitor | grep "Dell AW3420DW"
    then
      ${pkgs.xorg.xrandr}/bin/xrandr --newmode "3440x1440_60.00r" 319.75  3440 3488 3520 3600  1440 1443 1453 1481 +hsync -vsync 
      ${pkgs.xorg.xrandr}/bin/xrandr --addmode HDMI-1 "3440x1440_60.00r"
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode "3440x1440_60.00r" --above eDP-1
    else
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --auto --above eDP-1
    fi
  else
  	${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off
  fi
''
