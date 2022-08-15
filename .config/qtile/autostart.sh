#!/usr/bin/bash

# Setting up monitors
xrandr --output HDMI-1 --mode 1920x1080 --rate 75 --primary &

# autorandr

# Honeygain
honeygain &

# Wallpaper and pywalupdate
nitrogen --restore

# Disable mouse acceleration ("xinput list" to find mouse id)
disableMouseAccel &

# compositor
picom &

# keyboard layout
setxkbmap -layout us &

# clipmenud
clipmenud &

# Noise suppresion (not working)
#noisetorch -i &

# Email
neomutt &

# BlueLight
redshift &

# xob
volume-watcher.py | xob &
#brightness-watcher.py | xob &

# Startup programs
firefox-x11 &
#com.discordapp.Discord &
