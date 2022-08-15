from libqtile.dgroups import simple_key_binder
from typing import List  # noqa: F401

import os
import re

from libqtile import layout, hook
from libqtile.config import Click, Drag, Group, Key, Match
from libqtile.lazy import lazy

from screens import screens

mod = "mod4"
alt = "mod1"
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([alt], "Tab", lazy.screen.toggle_group(), desc="Toggle group"),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),

    # Rofi
    Key([mod], "e", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key([mod],
        "Escape",
        lazy.spawn(
            "/home/polsust/.config/polybar/forest/scripts/powermenu.sh"),
        desc="Launch rofi"),
    Key([mod], "c", lazy.spawn("clipmenu"), desc="Launch clipmenu"),

    # Dmenu
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Launch dmenu"),

    # Ranger
    Key([mod], "r", lazy.spawn("alacritty -e ranger"), desc="Launch ranger"),

    # Screenshot
    Key([mod, "shift"],
        "s",
        lazy.spawn("flameshot gui"),
        desc="Take a screenshot"),

    # Audio
    Key([], "XF86AudioRaiseVolume", lazy.spawn("changeVolume 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("changeVolume 5%-")),
    Key([], "XF86AudioMute",
        lazy.spawn("amixer -D pulse set Master 1+ toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),

    # Pulsemixer
    Key([mod], "p", lazy.spawn("alacritty -e pulsemixer")),
    # Neomutt
    Key([mod], "m", lazy.spawn("alacritty -e neomutt")),
    # Neovim
    Key([mod], "n", lazy.spawn("alacritty -e nvim")),
]

# (Workspaces)
groups = [
    Group("",
          layout="columns",
          matches=[
              Match(wm_class=re.compile(r".*?firefox*?", re.IGNORECASE), ),
          ]),  # 1
    Group(
        "",
        layout="columns",
        matches=[Match(wm_class=["code"])],
    ),  # 2
    Group(
        "",
        layout="columns",
        matches=[Match(wm_class=["discord"])],
    ),  # 3
    Group("",
          layout="columns",
          matches=[
              Match(wm_class=re.compile(
                  r".*?minecraft|steam|Terraria|stardew.*?", re.IGNORECASE), ),
          ]),  # 4
    Group("5", layout="columns"),  # 5
    Group("6", layout="columns"),  # 6
    Group("7", layout="columns"),  # 7
    Group("8", layout="columns"),  # 8
    Group("9", layout="columns"),  # 9
    Group("", layout="columns")  # 0
]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
dgroups_key_binder = simple_key_binder(mod)


@hook.subscribe.startup_once
def startup_once():
    home = os.path.expanduser('~')
    # subprocess.run(home + "/.config/qtile/autostart.sh")


@hook.subscribe.screen_change
def restart_on_randr(qtile):
    qtile.cmd_reload_config()


layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"],
                   border_width=2,
                   margin=5),
    layout.Spiral(),
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.Bsp(),
    layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    layout.VerticalTile(),
    layout.Zoomy(),
]

# widget_defaults = dict(
#     font="sans",
#     fontsize=12,
#     padding=3,
# )
# extension_defaults = widget_defaults.copy()

colors = [
    ["#021b21", "#021b21"],  # 0
    ["#032c36", "#065f73"],  # 1
    # ["#032c36", "#61778d"],# 1 this one is bit lighter, it is for inactive workspace icons.
    ["#e8dfd6", "#e8dfd6"],  # 2
    ["#c2454e", "#c2454e"],  # 3
    ["#44b5b1", "#44b5b1"],  # 4
    ["#9ed9d8", "#9ed9d8"],  # 5
    ["#f6f6c9", "#f6f6c9"],  # 6
    ["#61778d", "#61778d"],  # 7
    ["#e2c5dc", "#e2c5dc"],  # 8
    ["#5e8d87", "#5e8d87"],  # 9
    ["#032c36", "#032c36"],  # 10
    ["#2e3340", "#2e3340"],  # 11
    ["#065f73", "#065f73"],  # 12
    ["#8a7a63", "#8a7a63"],  # 13
    ["#A4947D", "#A4947D"],  # 14
    ["#BDAD96", "#BDAD96"],  # 15
    ["#a2d9b1", "#a2d9b1"],  # 16
]

#==== Widgets ====#

widget_defaults = dict(
    font="mono",
    fontsize=10,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = screens

# screens = [
#     Screen(
#         top=bar.Bar(
#             [
#                 widget.GroupBox(disable_drag=True, hide_unused=True),
#                 widget.CurrentLayoutIcon(),
#                 widget.CurrentLayout(),
#                 widget.WindowName(),

#                 widget.Bluetooth(
#                     hci="/dev_98_52_3D_05_AB_4F",
#                     background=colors[5]
#                 ),

#                 widget.Systray(background=colors[6]),
#                 # widget.Net(
#                 #     interface="wlo1",
#                 #     background=Color7,
#                 #     foreground="#000000"
#                 # ),
#                 widget.Volume(emoji=True),
#                 widget.Battery(
#                     format="{percent:1.0%}",
#                     notify_below=5,
#                     show_short_text=False
#                 ),
#                 widget.Clock(format="%a %d/%m %H:%M"),
#             ],
#             24,
#             background=colors[0],
#         ),
#     ),
# ]

# Drag floating layouts.
mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class="megasync"),  # MegaSync
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
