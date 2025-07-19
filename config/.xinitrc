xrandr --output eDP-1 --scale 0.8

unclutter -idle 1 &
dunst &
/usr/lib/policykit-1-pantheon/io.elementary.desktop.agent-polkit &

setxkbmap -model pc105 -layout us,ru -variant qwerty -option grp:lalt_lshift_toggle

exec /bin/i3
