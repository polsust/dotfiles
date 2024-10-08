import os
from libqtile.config import Key
from libqtile.lazy import lazy
from modules.settings import mod, alt

binds_system = [
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    #
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl set 5%+ -q')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl set 5%- -q')),
    #
    Key([mod, 'control'], 'Right', lazy.spawn('brightnessctl set 5%+ -q')),
    Key([mod, 'control'], 'Left', lazy.spawn('brightnessctl set 5%- -q')),
    #
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pamixer -i 5 --allow-boost')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pamixer -d 5 --allow-boost')),
    Key([], 'XF86AudioMute', lazy.spawn('pamixer -t')),
    #
    Key([mod, 'control'], 'Up', lazy.spawn('pamixer -i 5 --allow-boost')),
    Key([mod, 'control'], 'Down', lazy.spawn('pamixer -d 5 --allow-boost')),
    #
    Key([mod, 'control'], 'Shift_R', lazy.spawn('pamixer -t')),
    #
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioNext', lazy.spawn('playerctl next')),
    Key([], 'XF86AudioPrev', lazy.spawn('playerctl previous')),
    #
    Key([mod, alt], 'l', lazy.spawn('betterlockscreen -l')),
    Key(
        [mod, alt],
        'b',
        lazy.spawn(os.path.expanduser('~/.scripts/toggleJabra')),
    ),
    #
    Key(
        [mod, alt],
        'p',
        lazy.spawn("poweroff"),
    ),
    Key(
        [mod, alt],
        'r',
        lazy.spawn("reboot"),
    ),
    #
    Key(
        [mod, 'shift'],
        'e',
        lazy.spawn('setxkbmap es'),
    ),
    Key(
        [mod, 'shift'],
        'u',
        lazy.spawn('setxkbmap us'),
    ),
]
