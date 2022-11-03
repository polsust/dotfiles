require("persisted").setup({
	use_git_branch = false, -- create session files based on the branch of the git enabled repository
	branch_separator = "_", -- string used to separate session directory name from branch name
	autosave = true, -- automatically save session files when exiting Neovim
	autoload = false, -- automatically load the session for the cwd on Neovim startup
})
