#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
autorandr main

~/.fehbg &

picom --experimental-backends &

setxkbmap -option ctrl:nocaps &

unclutter -idle 5 &

# Daemons

systemctl --user import-environment DISPLAY # clipmenud
clipmenud &

dunst &

rescuetime &

batteryAlerts &

# Applications

nm-applet &

megasync &

firefox &

flameshot &

dailyNote &

"$HOME"/.scripts/pulse-volume-watcher.py | xob &

exec qtile start
