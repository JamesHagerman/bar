#!/bin/sh

clock() {
    date +%H:%M:%S
}

battery() {
    cat /sys/class/power_supply/BAT0/capacity
}


# List of all the monitors/screens you have in your setup
MONITORS=$(xrandr | grep -o "^.* connected" | sed "s/ connected//")

while true; do  
  BAR_INPUT="%{c}LIFE : $(battery)%% TIME : $(clock)"
  
  # Put the same thing on all monitors:
  MON_INDEX=0
  BAR_OUT=
  for m in $(echo "$MONITORS"); do
      BAR_OUT="$BAR_OUT%{S$MON_INDEX}$BAR_INPUT"
      MON_INDEX=$(( $MON_INDEX + 1 ))
  done
  
  # Spit out the combined command
  echo $BAR_OUT
  sleep 1
done

