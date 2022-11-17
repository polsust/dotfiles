from libqtile.config import Key
from libqtile.lazy import lazy
from modules.settings import mod, apps
from modules.helpers import spawn_in_terminal

binds_launchers = [
    Key([mod], 't', lazy.spawn(apps['terminal']), desc='Launch terminal'),
    Key(
        [mod],
        'e',
        lazy.spawn('rofi -show drun'),
        desc='Launch rofi app mode',
    ),
    Key(
        [mod],
        'd',
        lazy.spawn('rofi -show run'),
        desc='Launch rofi scripts mode',
    ),
    Key(
        [mod],
        'c',
        lazy.spawn(apps['calculator']),
        desc='Launch calculator',
    ),
    Key(
        [mod],
        'v',
        lazy.spawn('clipmenu'),
        desc='Launch clipboard manager',
    ),
    Key(
        [mod],
        'b',
        lazy.spawn(apps['bluetooth_manager']),
        desc='Launch bluetooth manager',
    ),
    #
    Key(
        [mod],
        'x',
        lazy.spawn('gpick -p'),
        desc='Launch colorpicker',
    ),
    Key(
        [mod, 'shift'],
        's',
        lazy.spawn('flameshot gui'),
        desc='Launch flameshot',
    ),
    Key(
        [mod],
        'p',
        lazy.spawn(spawn_in_terminal('pulsemixer')),
        desc='Launch pulsemixer',
    ),
    Key(
        [mod],
        'r',
        lazy.spawn(spawn_in_terminal(apps['tui_file_manager'])),
        desc='Launch tui file manager',
    ),
    Key(
        [mod],
        'w',
        lazy.spawn(apps['web_browser']),
        desc='Launch web browser',
    ),
    Key(
        [mod, 'shift'],
        'f',
        lazy.spawn(apps['gui_file_manager']),
        desc='Launch gui file manager',
    ),
    Key(
        [mod],
        'n',
        lazy.spawn(apps['code_editor']),
        desc='Launch code editor',
    ),
    Key(
        [mod],
        'y',
        lazy.spawn('ytplay'),
        desc='Launch youtube videos search bar',
    ),
]
