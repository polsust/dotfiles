from modules.groups import *
from modules.layouts import *
from modules.settings import *
from modules.screens import *

from modules.binds.binds_launchers import binds_launchers
from modules.binds.binds_system import binds_system
from modules.binds.binds_windows import binds_windows

keys = []
keys.extend(binds_launchers)
keys.extend(binds_system)
keys.extend(binds_windows)
