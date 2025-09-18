from libqtile.config import Key
from libqtile.lazy import lazy
from modules.settings import mod, apps, alt, home
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
        'period',
        lazy.spawn('rofimoji'),
        desc='Launch rofi emoji picker',
    ),
    Key(
        [mod],
        'comma',
        lazy.spawn('rofiGlyphs'),
        desc='Launch rofi glyph picker',
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
        lazy.spawn(spawn_in_terminal(apps['bluetooth_manager'])),
        desc='Launch bluetooth manager',
    ),
    Key(
        [mod, "shift"],
        'b',
        lazy.spawn(spawn_in_terminal('btop')),
        desc='Launch bashtop',
    ),
    #
    Key(
        [mod, 'shift'],
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
        lazy.spawn(spawn_in_terminal('ranger')),
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
        'w',
        lazy.spawn(
            f"{apps['web_browser']} -new-window https://web.whatsapp.com"
        ),
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
        lazy.spawn(spawn_in_terminal("nvim")),
        desc='Launch nvim',
    ),
    Key(
        [mod, 'shift'],
        'n',
        lazy.spawn(spawn_in_terminal(f"nvim {home}/notes")),
        desc='Launch notes',
    ),
    Key(
        [mod],
        'm',
        lazy.spawn(spawn_in_terminal('dailyNote')),
        desc='Launch dailynote',
    ),
    Key(
        [mod],
        'y',
        lazy.spawn('ytplay'),
        desc='Launch youtube videos search bar',
    ),
    Key(
        [mod, 'shift'],
        'z',
        lazy.spawn('get-window-class'),
        desc='Get the class of a window',
    ),
    Key(
        [mod, 'shift'],
        'p',
        lazy.spawn('spotify-launcher'),
        desc='Launch spotify',
    ),
    Key(
        [mod],
        'o',
        lazy.spawn(spawn_in_terminal('calcurse')),
        desc='Launch calcurse',
    ),
]
