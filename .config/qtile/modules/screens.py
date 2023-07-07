from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen
from modules.colors import Colors

widget_defaults = dict(
    font='Mononoki',
    fontsize=15,
    padding=8,
    border=Colors.light,
    border_width=10,
    foreground=Colors.lighter,
    background=Colors.dark,
)
extension_defaults = widget_defaults.copy()

opening_sep = widget.TextBox(fmt='[')

closing_sep = widget.TextBox(fmt=']')

screens = [
    Screen(
        top=bar.Bar(
            [
                opening_sep,
                widget.GroupBox(
                    highlight_method='text',
                    fmt='[{}]',
                    disable_drag=True,
                    padding=0,
                    margin_y=3,
                    active=Colors.light,  # Active group font colour
                    hide_unused=False,  # Hide groups that have no windows and that are not displayed on any screen.
                    # other_current_screen_border=colors['darker'], #Border or line colour for group on other screen when focused.
                    # other_screen_border=colors['darker'], #Border or line colour for group on other screen when unfocused.
                    this_current_screen_border=Colors.lighter,  # Border or line colour for group on this screen when focused.
                    # this_screen_border=colors['lighter'], #Border or line colour for group on this screen when unfocused.
                    urgent_alert_method='text',
                    urgent_text=Colors.special.light,  # Urgent group font color
                ),
                closing_sep,
                opening_sep,
                widget.CurrentLayoutIcon(
                    scale=0.5,
                ),
                widget.CurrentLayout(),
                closing_sep,
                # widget.WindowName(
                #     format='[ {name} ]',
                #     empty_group_string='Desktop',
                # ),
                widget.KeyboardLayout(
                    configured_keyboards=['us', 'es'],
                    fmt='[ 󰌌 {} ]',
                ),
                widget.Spacer(length=bar.STRETCH),
                opening_sep,
                widget.TextBox(
                    padding=0,
                    fmt=' ',
                    fontsize=21,
                ),
                widget.Clock(
                    format='%d-%m-%Y %A ] [ 󰥔  %H:%M ]',
                ),
                widget.Spacer(length=bar.STRETCH),
                opening_sep,
                widget.Systray(
                    icon_size=20,
                ),
                closing_sep,
                opening_sep,
                # widget.Bluetooth(
                #     fmt="{}",
                #     hci="/dev_28:6F:40:A1:1D:8D",
                # ),
                widget.CheckUpdates(
                    colour_have_updates=Colors.lighter,
                    colour_no_updates=Colors.lighter,
                    display_format='{updates}',
                    fmt='󰚰  {}',
                    no_update_string='0',
                    custom_command="paru -Qu"
                ),
                closing_sep,
                opening_sep,
                widget.Wlan(
                    disconnected_message='󰖪  No signal',
                    format='󰖩  {essid} {percent:2.0%}',
                    interface='wlan0',
                    update_interval=5,
                ),
                closing_sep,
                opening_sep,
                widget.BatteryIcon(
                    theme_path='~/.config/qtile/assets/battery/',
                    scale=0.9,
                ),
                widget.Battery(
                    format='{percent:1.0%}',
                ),
                closing_sep,
                opening_sep,
                widget.Volume(
                    theme_path='~/.config/qtile/assets/volume/',
                    padding=0,
                ),
                widget.Volume(),
                closing_sep,
            ],
            30,
            border_color=Colors.lighter,
            border_width=2,
            margin=10,
        ),
    ),
]
