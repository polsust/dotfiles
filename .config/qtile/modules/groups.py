import re
from libqtile import qtile
from libqtile.config import Group, Key
from libqtile.config import Match
from libqtile.lazy import lazy
from modules.settings import mod, alt
from libqtile.log_utils import logger


groups_blueprint = [
    Group('1', label="1"),
    Group('2', label="2"),
    Group('3', label="3"),
    Group(
        '4', label="4",
        matches=[
            Match(wm_class='minecraft-launcher'),
            Match(wm_class=re.compile(r'Minecraft Launcher.*')),
            Match(wm_class=re.compile(r'steam.*')),
            Match(wm_class='artofrally.x64'),
        ],
    ),
    Group('5', label="5"),
    Group('6', label="6"),
    Group('7', label="7", matches=[Match(wm_class=re.compile(r'discord.*'))]),
    Group('8', label="8"),
    Group('9', label="9", matches=[Match(wm_class='Spotify')]),
    Group('0', label="0"),
]

groups = groups_blueprint

@lazy.function
def swap_groups(qtile):
    logger.warning('swap') 
    qtile.cmd_del_group("4")
    # delete_all_groups()

    # groups = map(change_group, groups_blueprint)


def delete_all_groups():
    for group in list(qtile.groups):
        try:
           qtile.cmd_del_group(group)
        except Exception as e:
            print(f"Error deleting group {group}: {e}")


def change_group(group: Group):
    group.label = f'{group.label}.1'
    return group
