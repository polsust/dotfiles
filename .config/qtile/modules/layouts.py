from libqtile import layout
from libqtile.config import Match
from modules.colors import colors

layouts = [
    layout.Columns(
        border_normal=colors['light'],
        border_focus=colors['lighter'],
        border_focus_stack=colors['special']['light'],
        border_normal_stack=colors['special']['dark'],
        border_width=4,
        insert_position=1,
        margin=5,
        wrap_focus_columns=False,
        wrap_focus_rows=False,
        wrap_focus_stacks=True,
    ),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.Zoomy(),
    # layout.VerticalTile(),
]
floating_layout = layout.Floating(
    border_normal=colors['light'],
    border_focus=colors['lighter'],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='pinentry'),  # GPG key password entry
        #
        Match(wm_class='megasync'),
        Match(wm_class='pulsemixer'),
        Match(wm_class='blueman-manager'),
        Match(title='NoiseTorch'),
        Match(title='Event Tester'),  # xev
    ],
)
