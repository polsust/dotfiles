local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

local terminal = "alacritty"

local function launch_on_terminal(app)
  return terminal .. " --class='" .. app .. "," .. app .. "' -e " .. app
end

return {
  --- Default Applications
  default = {
    --- Default terminal emulator
    terminal = terminal,
    --- Default music client
    music_player = launch_on_terminal("ncmpcpp"),
    --- Default text editor
    text_editor = launch_on_terminal("lvim"),
    --- Default code editor
    code_editor = launch_on_terminal("lvim"),
    --- Default audio mixer
    audio_mixer = launch_on_terminal("pulsemixer"),
    --- Default web browser
    web_browser = "firefox",
    --- Default file manager
    file_manager = "pcmanfm",
    --- Default terminal file manager
    terminal_file_manager = launch_on_terminal("ranger"),
    --- Default network manager
    network_manager = "networkmanager_dmenu",
    --- Default bluetooth manager
    bluetooth_manager = "blueman-manager",
    --- Default power manager
    power_manager = "xfce4-power-manager",
    --- Default rofi global menu
    app_launcher = "rofi -no-lazy-grab -show drun -modi drun",
    --- Default rofi script launcher
    script_launcher = "rofi -no-lazy-grab -show run -modi run",
    --- Default emoji selector
    emoji_selector = "rofi -show emoji",
    --- Default emoji selector
    calculator = "rofi -show calc",
    --- Default window finder
    window_finder = "rofi -modi window -show window",
    --- Default clipboard manager
    clipboard_manager = "clipmenu"
  },

  --- List of binaries/shell scripts that will execute for a certain task
  utils = {
    --- Fullscreen screenshot
    full_screenshot = "screensht full",
    --- Area screenshot
    area_screenshot = "flameshot gui",
    --- Color Picker
    color_picker = utils_dir .. "xcolor-pick",
  },
}
