#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
autorandr main

~/.fehbg &

picom &

setxkbmap -option ctrl:nocaps &

unclutter -idle 5 &

# Daemons

snixembed & # compatibility for certain trail apps like iwgtk

systemctl --user import-environment DISPLAY # clipmenud
clipmenud &

dunst &

rescuetime &

panorama &

# Applications

iwgtk -i &

nm-applet &

megasync &

firefox &

discord &

steam -silent &

flameshot &

blueman-applet &

"$HOME"/.scripts/volume-watcher | xob &
"$HOME"/.scripts/brightness-bar &

exec qtile start
