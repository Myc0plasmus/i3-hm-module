{ pkgs }:

pkgs.writeShellScriptBin "batteryScript" ''
  while true
  do
      if on_ac_power; then 
          brightnessctl set 20%              ## Laptop on power
      else
          brightnessctl set 80%              ## Laptop on power
      fi
      sleep 10                       ## wait 10 sec before repeating
  done
''
