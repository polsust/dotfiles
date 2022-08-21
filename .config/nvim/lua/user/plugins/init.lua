return {
	{
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	}, -- Run nvim on the browser
	{ "folke/tokyonight.nvim" }, -- Theme
	{ "dcampos/nvim-snippy" }, -- Snippets
	{ "APZelos/blamer.nvim" }, -- Git blame in-line
	{ "noahfrederick/vim-laravel" }, -- Laravel support
	{ "github/copilot.vim" }, -- Github copilot
	{ "joshdick/onedark.vim" }, -- Onedark theme
	{ "sheerun/vim-polyglot" }, -- Language syntax hightlighting
	{ "wfxr/minimap.vim" }, -- Minimap
	{ "Pocco81/auto-save.nvim" }, -- Auto save

	-- CMP
	-- {
	--   "dcampos/cmp-snippy",
	--   after = "nvim-cmp",
	--   config = function() astronvim.add_cmp_source "snippy" end,
	-- }, -- Nvim-snippy integration
	-- {
	--   "mtoohey31/cmp-fish",
	--   after = "nvim-cmp",
	--   config = function() astronvim.add_cmp_source "fish" end,
	-- }, -- Since fish has no lsp
}
