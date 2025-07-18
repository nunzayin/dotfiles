xrandr --output eDP-1 --scale 0.8

unclutter -idle 1 &
setxkbmap -model pc105 -layout us,ru -variant qwerty -option grp:lalt_lshift_toggle
dunst &

exec /bin/i3
