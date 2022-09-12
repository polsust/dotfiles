local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- ["<C-k>"] =
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-I" },
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})
telescope.load_extension("aerial")
