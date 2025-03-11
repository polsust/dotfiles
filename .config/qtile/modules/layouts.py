from libqtile import layout
from libqtile.config import Match
from modules.colors import Colors

default_opts = dict(
    border_normal=Colors.light,
    border_focus=Colors.lighter,
    border_focus_stack=Colors.special.light,
    border_normal_stack=Colors.special.dark,
    border_width=4,
    insert_position=1,
    margin=5,
    wrap_focus_columns=False,
    wrap_focus_rows=False,
    wrap_focus_stacks=True,
)

layouts = [
    layout.Columns(**default_opts),
    layout.Max(**default_opts),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**default_opts),
    # layout.Matrix(**default_opts),
    # layout.MonadTall(**default_opts),
    # layout.MonadWide(**default_opts),
    # layout.RatioTile(**default_opts),
    # layout.Tile(**default_opts),
    # layout.TreeTab(**default_opts),
    # layout.Zoomy(**default_opts),
    # layout.VerticalTile(**default_opts),
]
floating_layout = layout.Floating(
    border_normal=Colors.light,
    border_focus=Colors.lighter,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='pinentry'),  # GPG key password entry
        #
        Match(wm_class='megasync'),
        Match(wm_class='bluetuith'),
        Match(wm_class='bluetui'),
        Match(wm_class='pulsemixer'),
        Match(wm_class='blueman-manager'),
        Match(title='NoiseTorch'),
        Match(title='Event Tester'),  # xev
    ],
)
