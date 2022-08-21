#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
setupMonitors

~/.fehbg &

picom --experimental-backends &

setxkbmap -option ctrl:nocaps &

honeygain &

# Daemons

clipmenud &

dunst &

# Applications

nm-applet &

firefox &

exec qtile start
