import os
from libqtile.config import Key
from libqtile.lazy import lazy
from modules.settings import mod, alt
from modules.helpers import spawn_in_terminal

binds_system = [
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 5%+ -q")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%- -q")),
    #
    Key([mod, alt], "Right", lazy.spawn("brightnessctl set 5%+ -q")),
    Key([mod, alt], "Left", lazy.spawn("brightnessctl set 5%- -q")),
    #
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    #
    Key([mod, alt], "Up", lazy.spawn("pamixer -i 5")),
    Key([mod, alt], "Down", lazy.spawn("pamixer -d 5")),
    Key([mod, alt], "k", lazy.spawn("pamixer -i 5")),
    Key([mod, alt], "j", lazy.spawn("pamixer -d 5")),
    Key([mod, alt], "h", lazy.spawn("brightnessctl set 5%- -q")),
    Key([mod, alt], "l", lazy.spawn("brightnessctl set 5%+ -q")),
    #
    Key([mod, "control"], "Shift_R", lazy.spawn("pamixer -t")),
    #
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    #
    Key([mod, "shift", "control"], "l", lazy.spawn("betterlockscreen -l")),
    Key(
        [mod, alt],
        "b",
        lazy.spawn("toggleJabra"),
    ),
    Key([mod, "shift"], "o", lazy.spawn("set-default-output-source")),
    Key([mod, "shift"], "i", lazy.spawn("set-default-input-source")),
    #
    Key(
        [mod, alt],
        "p",
        lazy.spawn("poweroff"),
    ),
    Key(
        [mod, alt],
        "r",
        lazy.spawn("reboot"),
    ),
    Key(
        [mod, alt],
        "u",
        lazy.spawn(spawn_in_terminal("paru -Syu")),
    ),
    #
    Key(
        [mod, "shift"],
        "e",
        lazy.spawn("setxkbmap es"),
    ),
    Key(
        [mod, "shift"],
        "u",
        lazy.spawn("setxkbmap us"),
    ),
]
