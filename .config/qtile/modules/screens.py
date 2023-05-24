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
                widget.GroupBox(
                    borderwidth=3,
                    highlight_method='block',
                    rounded=True,
                    disable_drag=True,
                ),
                widget.CurrentLayoutIcon(
                    scale=0.6,
                ),
                widget.WindowName(
                    format='{name}',
                    empty_group_string='Desktop',
                    fontsize=13,
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.Clock(
                    fontsize=20,
                    format='[ %d-%m-%Y',
                ),
                widget.TextBox(
                    padding=5,
                    fmt='',
                    fontsize=30,
                ),
                widget.TextBox(
                    padding=5,
                    fmt='][',
                    fontsize=20,
                ),
                widget.Clock(
                    fontsize=20,
                    format='%A %R 󰥔 ]',
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.Sep(padding=20, linewidth=2),
                widget.Systray(
                    fontsize=2,
                ),
                widget.Sep(padding=20, linewidth=2),
                widget.Memory(
                    format='{MemUsed: .0f}{mm}',
                    fontsize=13,
                    update_interval=5,
                ),
                widget.Sep(padding=20, linewidth=2),
                widget.Battery(
                    format='{percent:1.0%}',
                    fontsize=13,
                ),
                widget.BatteryIcon(
                    theme_path='~/.config/qtile/assets/battery/',
                    scale=1,
                ),
                widget.Sep(padding=20, linewidth=2),
                widget.Volume(),
                widget.Volume(
                    theme_path='~/.config/qtile/assets/volume/',
                    padding=0
                ),
                widget.Sep(padding=20, linewidth=2),
            ],
            30,
            border_color='#282738',
            border_width=[0, 0, 0, 0],
            margin=[15, 60, 6, 60],
        ),
    ),
]
