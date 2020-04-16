#!/bin/sh

#if [ $(pgrep -fcx $(basename $0)) -gt 1 ]; then
#  printf "%s\n" "The lemonbar is already running." >&2
#  exit 1
#fi

# Bold/"Bright" palette:
BACKGROUND="#000000"
BLACK="#7C6D65"
#FF54A9 - red
GREEN="#A9FF54"
#FFA954 - yellow
#54A9FF - blue
#A954FF - magenta
#54FFA9 - cyan
WHITE="#F4E5DD"

clock() {
    date +%H:%M:%S
}

battery() {
    cat /sys/class/power_supply/BAT0/capacity
}

# Paren here are to keep IFS from being set permenantly...
(IFS='
'

# List of all the monitors/screens you have in your setup
MONITORS=$(xrandr | grep -o "^.* connected" | sed "s/ connected//")
# echo "$MONITORS"

while true; do  
  # Put the same thing on all monitors:
  MON_INDEX=1
  BAR_OUT=
  for m in $MONITORS; do
    # echo 
    WORKSPACES=$(i3-msg -t get_workspaces | jq --arg MONITOR "$m" -r '.[] | select(.output==$MONITOR) | { name, focused, urgent }' -c)
    # FOCUSED_NAME=$(i3-msg -t get_workspaces | jq '.[] | select(.output=="DP-1" and .focused==true) | { name, focused, urgent }' -c)
    # echo "Workspaces on $m:"
    # echo "$WORKSPACES" # workspace JSON string 

    WS_TXT=""
    for ws in $WORKSPACES; do
      NAME=$(echo $ws | jq '.name' -c -r)
      WS_ESCAPED=$(echo "$NAME" | sed 's/:/\\:/')

      # These two values are "true" of "false" and bash has to handle them with a single '=':
      FOCUSED=$(echo $ws | jq '.focused' -c -r)
      URGENT=$(echo $ws | jq '.urgent' -c -r)
      # echo "OKAY: $NAME, $FOCUSED, $URGENT"

      COLOR_START="%{B$BLACK}%{F$WHITE}"
      COLOR_END="%{F-}%{B-}"

      if [ "$FOCUSED" = true ]; then
        COLOR_START="%{B$GREEN}%{F$BACKGROUND}"
        COLOR_END="%{F-}%{B-}"
      fi
      # echo "$COLOR_START, $COLOR_END"

      WS_TXT="$WS_TXT$COLOR_START%{A:i3-msg workspace $WS_ESCAPED:} $NAME %{A}$COLOR_END"
      # WS_TXT="$WS_TXT$NAME "
    done

    # echo "DONE: $WS_TXT"

    # BAR_INPUT="$WS_TXT %{c}LIFE : $(battery)%% TIME : $(clock)"
    BAR_INPUT="$WS_TXT"

    BAR_OUT="$BAR_OUT%{S$MON_INDEX}$BAR_INPUT"
    MON_INDEX=$(( $MON_INDEX - 1 ))
  done
  
  # Spit out the combined command
  echo $BAR_OUT

  # This makes too many bars:
  #echo $BAR_OUT | lemonbar -p -b
  # sleep 1
  # sleep 5
  sleep 0.01s
done

) # Final paran to keep IFS from being set permentantly
