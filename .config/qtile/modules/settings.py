mod = 'mod4'
alt = 'mod1'

apps = {
    'terminal': 'alacritty',
    'gui_file_manager': 'pcmanfm',
    'tui_file_manager': 'ranger',
    'web_browser': 'firefox',
    'code_editor': 'nvim',
    'bluetooth_manager': 'bluetuith',
    'calculator': 'rofi -show calc',
}


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
bring_front_click = False
follow_mouse_focus = True
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = 'LG3D'
