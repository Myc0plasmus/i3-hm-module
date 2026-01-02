{ pkgs }:

pkgs.writeShellScriptBin "monitorScript" ''
  xrandrBin=${pkgs.xorg.xrandr}/bin/xrandr
  hwinfoBin=${pkgs.hwinfo}/bin/hwinfo 

  # if ${pkgs.xorg.xrandr}/bin/xrandr --query | grep "HDMI-1 connected"
  # then
  #   if ${pkgs.hwinfo}/bin/hwinfo --monitor | grep "Dell AW3420DW"
  #   then
  #     ${pkgs.xorg.xrandr}/bin/xrandr --newmode "3440x1440_60.00r" 319.75  3440 3488 3520 3600  1440 1443 1453 1481 +hsync -vsync 
  #     ${pkgs.xorg.xrandr}/bin/xrandr --addmode HDMI-1 "3440x1440_60.00r"
  #     ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode "3440x1440_60.00r" --above eDP-1
  #   else
  #     ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --auto --above eDP-1
  #   fi
  # else
  # 	${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off
  # fi

  connected() {
    xrandr | awk '/ connected/{print $1}'
  }

  is_connected() {
      xrandr | grep -q "^$1 connected"
  }

  laptop_layout() {
    INTERNAL="eDP-1"

    HDMI=$(xrandr | awk '/^HDMI-[0-9]+ connected/{print $1; exit}')

    if [ -n "$HDMI" ]; then
        xrandr \
            --output "$HDMI" --auto --primary \
            --output "$INTERNAL" --auto --below "$HDMI"
    else
        xrandr --output "$INTERNAL" --auto --primary
    fi
  }

  pc_layout() {
    DUMMY="HDMI-0"        # dummy plug
    BIG_DP="DP-2"         # big ultrawide
    SMALL_HDMI="HDMI-1"   # small screen

    # Always bring up dummy as primary
    xrandr --output "$DUMMY" --auto --primary

    if is_connected "$BIG_DP"; then
        xrandr \
            --output "$BIG_DP" --auto --left-of "$DUMMY"

        if is_connected "$SMALL_HDMI"; then
            xrandr \
                --output "$SMALL_HDMI" --auto --below "$BIG_DP"
        else
            xrandr --output "$SMALL_HDMI" --off
        fi
    else
        xrandr \
            --output "$BIG_DP" --off \
            --output "$SMALL_HDMI" --off
    fi
  }

  case "$1" in
    myc0plasmus)
        laptop_layout
        ;;
    cordyceps)
        pc_layout
        ;;
    *)
        echo "Usage: $0 {laptop|pc}"
        exit 1
        ;;
    esac
  
  
''
