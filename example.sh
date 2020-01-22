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
  # This is a simple example. It shows how clickable areas work, centering, and right justification.
  # Clicking a clickable area will send the command (`ls` in this case) to standard out (stdout). For this to be useful,
  # the output of `lemonbar` should be passed to another program.
  #
  # A really bad idea (use at your own risk) is to pipe directly to `/bin/bash` so your able to run other programs.
  # ./example.sh | ./lemonbar -g 1920x50+0+0 -p | /bin/bash
  #
  # A better option would be to pipe the output to another program that can parse whatever madness you dump to stdout.
  BAR_INPUT="Left %{A:ls:} Click here to write to stdout %{A} %{c}$(clock) | BAT $(battery)%% %{r}Right"
  
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

