#!/bin/sh

# This has to be without the "&" so the monitors are configured properly before proceading
##setupMonitors

# ~/.fehbg &

##picom --experimental-backends &

##setxkbmap -option ctrl:nocaps &

##honeygain &

# Xmonad specific

# trayer --monitor 1 --edge top --align right --SetDockType true --SetPartialStrut true \
    #                    --expand true --width 10 --transparent true --tint 0x303145 --height 22 &

# End xmonad specific

# Daemons

##clipmenud &

##dunst &

# /usr/bin/emacs --daemon &

# Applications

## nm-applet &

# firefox &

# alacritty &

exec qtile start
