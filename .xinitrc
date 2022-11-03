#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
autorandr main

~/.fehbg &

picom --experimental-backends &

setxkbmap -option ctrl:nocaps &

unclutter -idle 5 &

honeygain &

# Daemons

clipmenud &

dunst &

# Applications

nm-applet &

firefox &

exec qtile start
