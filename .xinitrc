#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
autorandr main

xset r rate 300 30 &
setxkbmap -option compose:ralt,caps:escape_shifted_capslock

~/.fehbg &

picom &

unclutter -idle 5 &

# Daemons

eww daemon &

snixembed & # compatibility for certain trail apps like iwgtk

systemctl --user import-environment DISPLAY # clipmenud
clipmenud &

dunst &

poweralertd -s &

# Applications

iwgtk -i &

nm-applet &

megasync &

firefox &

discord &

steam -silent &

blueman-applet &

volume-bar &
brightness-bar &

exec qtile start
