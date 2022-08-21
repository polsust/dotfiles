from libqtile.config import Key
from libqtile.lazy import lazy
from modules.settings import mod

binds_system = [
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
]
