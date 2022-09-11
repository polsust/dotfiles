local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	sort_by = "name",
	view = {
		side = "left",
		mappings = {
			list = {
				{ key = "h", action = "navigate.parent_close" },
				{ key = "l", action = "edit" },
			},
		},
	},
	renderer = {
		highlight_git = true,
		full_name = true,
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "init.lua" },
	},
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 50,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = false,
		custom = { ".git" },
		exclude = { "node_modules" },
	},
	git = {
		enable = true,
		ignore = true,
		show_on_dirs = true,
		timeout = 400,
	},
	actions = {
		use_system_clipboard = true,
		open_file = {
			quit_on_open = false,
			resize_window = true,
		},
	},
})
