{ pkgs }:

pkgs.writeShellScriptBin "launchPolybar" ''
  # Terminate already running bar instances
  # If all your bars have ipc enabled, you can use 
  # polybar-msg cmd quit
  # Otherwise you can use the nuclear option:
  ${pkgs.killall}/bin/killall -q polybar

  if type "xrandr"; then
    for m in $(${pkgs.xorg.xrandr}/bin/xrandr --query | grep " connected" | cut -d" " -f1); do
  	MONITOR=$m ${pkgs.polybar}/bin/polybar --reload mybar &
    done
  else
    ${pkgs.polybar}/bin/polybar --reload mybar &
  fi

  echo "Bars launched..."
''
