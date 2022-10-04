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
				["<C-k>"] = "move_selection_previous",
				["<C-j>"] = "move_selection_next",
			},
		},
	},
	file_ignore_patterns = {
		"node_modules",
		".next",
		".git",
		"composer.lock",
		"package-lock.json",
		"yarn.lock",
		"vendor",
		"dist",
		"yarn.lock",
		"package-lock.json",
	},
	pickers = {
		find_files = {
			-- find_command = { "rg", "-uuu", "--files" },
		},
	},
})
-- telescope.load_extension("aerial")
