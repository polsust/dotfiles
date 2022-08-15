#!/usr/bin/sh
source ~/.bashrc
alias firefox="firefox-x11"

run() {
  if ! pgrep -f "$1" ;
    then
        "$@"&
        fi
}

# Setting up monitors
if xrandr | grep -q 'HDMI-1 connected' ; then
   xrandr --output HDMI-1 --primary --mode 1920x1080 --rate 75 &
fi

# Wallpaper and pywalupdate
nitrogen --restore &

# not sure this works
nitrogenWallpaperPath=$(getNitrogenWallpaperPath) &
wal -in "$nitrogenWallpaperPath" &

# autorandr

# Honeygain
run "honeygain"

# Disable mouse acceleration ("xinput list" to find mouse id)
disableMouseAccel &

# Compositor 
run "picom"

# Keyboard layout
setxkbmap -layout 'us,es'

# clipmenud
run "clipmenud"

# Noise suppresion (not working)
#noisetorch -i &

# Email
run "neomutt"

# BlueLight
run "redshift"

# xob
#run "volume-watcher.py | xob"
#brightness-watcher.py | xob & 

# Startup programs
run "firefox"
run "com.discordapp.Discord"

