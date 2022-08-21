from modules.settings import apps

terminal = apps['terminal']


def spawn_in_terminal(app):
    return (
        terminal
        + ' --class="'
        + app
        + ','
        + terminal.capitalize()
        + '" -e '
        + app
    )
