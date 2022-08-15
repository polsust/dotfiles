from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen
from colors import colors

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    text="  ",
                    font="Iosevka Nerd Font",
                    fontsize="18",
                ),

                widget.GroupBox(
                    disable_drag=True,
                    hide_unused=True,
                    font="Ubuntu Nerd Font",
                    fontsize=16,
                    margin_y=3,
                    margin_x=6,
                    padding_y=7,
                    padding_x=6,
                    borderwidth=4,
                    rounded=True,
                    highlight_method="block",
                    this_current_screen_border=colors[6],
                    block_highlight_text_color=colors[0],
                ),

                widget.CurrentLayoutIcon(
                    scale=0.45,
                    padding=0,
                    fontsize=14,
                    mouse_callbacks={
                        "Button3": lazy.prev_layout()
                    }
                ),
                widget.CurrentLayout(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                ),

                widget.WindowName(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                ),

                widget.Spacer(length=200),

                widget.Bluetooth(
                    fmt=" {}",
                    fontsize="15",
                    hci="/dev_98_52_3D_05_AB_4F",
                    padding=10,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            "blueman-manager")
                    },
                ),

                widget.TextBox(
                    text=" ",
                    font="Iosevka Nerd Font",
                    fontsize=18,
                    padding=0,
                ),
                widget.DF(
                    fmt=" {}",
                    font="Iosevka Nerd Font",
                    fontsize=15,
                    partition="/home",
                    format="{uf}{m} ({r:.0f}%)",
                    visible_on_warn=False,
                    padding=0,
                ),

                widget.TextBox(
                    text=" ",
                    font="Iosevka Nerd Font",
                    fontsize=16,
                    padding=10,
                ),
                widget.ThermalZone(
                    fontsize="12",
                    crit=90,
                    color="#00000",
                ),

                # RAM
                widget.TextBox(
                    text=" ",
                    font="Iosevka Nerd Font",
                    fontsize=16,
                    padding=0,
                ),
                widget.Memory(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                    measure_mem='G',
                    format="{MemUsed: .0f}{mm} / {MemTotal: .0f}{mm}",
                ),

                widget.Systray(
                    icons_size=18,
                    padding=4,
                ),

                widget.TextBox(
                    text="墳 ",
                    font="Iosevka Nerd Font",
                    fontsize=18,
                ),
                widget.Volume(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                ),

                widget.KeyboardLayout(
                    fmt=" {} הּ ",
                    font="Iosevka Nerd Font",
                    configured_keyboards=["us", "es"],
                    fontsize="14",
                    padding=0,
                ),

                # widget.BatteryIcon(
                #     theme_path="/home/polsust/.config/qtile/icons/battery",
                #     icon_size=0
                # ),
                widget.Battery(
                    format="{percent:1.0%}",
                    notify_below=5,
                    show_short_text=False
                ),

                widget.TextBox(
                    text="   ",
                    font="Iosevka Nerd Font",
                    fontsize="14",
                    padding=0,
                ),
                widget.Clock(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                    format="%d %b, %A",
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            "firefox --new-tab calendar.google.com/")
                    }
                ),

                widget.TextBox(
                    text=" ",
                    font="Iosevka Nerd Font",
                    fontsize="18",
                    padding=0,
                ),
                widget.Clock(
                    font="Iosevka Nerd Font",
                    fontsize=15,
                    padding=20,
                    format="%H:%M",
                ),
            ],
            size=28,
            opacity=0.9,
            background=colors[0],
            margin=5,
        ),
    ),
    Screen()
]
