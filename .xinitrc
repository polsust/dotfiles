#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
autorandr main

~/.fehbg &

picom --experimental-backends &

setxkbmap -option ctrl:nocaps &

unclutter -idle 5 &

# Daemons

clipmenud &

dunst &

# Applications

nm-applet &

firefox &

"$HOME"/.scripts/pulse-volume-watcher.py | xob &

exec qtile start
