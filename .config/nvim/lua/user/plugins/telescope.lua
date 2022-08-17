require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".next", ".git", "composer.lock", "package-lock.json", "yarn.lock" },
	},
})
