from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen
from modules.colors import colors

widget_defaults = dict(
    font='Mononoki',
    fontsize=16,
    padding=10,
    border=colors['light'],
    border_width=10,
    foreground=colors['lighter'],
    background=colors['dark'],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                #
                widget.GroupBox(
                    highlight_method='block',
                    inactive=colors['light'],
                    disable_drag=True,
                ),
                #
                widget.CurrentLayoutIcon(
                    scale=0.6,
                ),
                widget.CurrentLayout(),
                widget.Spacer(length=bar.STRETCH, background=colors['darker']),
                widget.Clock(
                    format='%d-%m-%Y %A %R',
                ),
                widget.Spacer(length=bar.STRETCH, background=colors['darker']),
                #
                widget.Systray(),
                widget.TextBox('  ', background=colors['darker']),
                widget.Bluetooth(
                    fmt=' {}',
                    fontsize='15',
                    hci='/dev_98_52_3D_05_AB_4F',
                    padding=10,
                    mouse_callbacks={'Button1': lazy.spawn('blueman-manager')},
                ),
                #
                widget.Battery(
                    format='{percent:1.0%}',
                    notify_below=5,
                    show_short_text=False,
                ),
                #
                # widget.Wttr(location={'91.161.80.235': 'Current location'}),
                #
            ],
            background=colors['dark'],
            border_color=colors['darker'],
            border_width=10,
            size=28,
            margin=4,
        ),
    ),
]
