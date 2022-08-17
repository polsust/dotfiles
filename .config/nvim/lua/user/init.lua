local config = {

	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme
	colorscheme = "onedark",

	-- Override highlight groups in any theme
	highlights = {
		default_theme = function(highlights) -- or a function that returns one
			local C = require("default_theme.colors")

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			relativenumber = true, -- sets vim.opt.relativenumber
			-- foldmethod = "expr",
			-- foldexpr = "nvim_treesitter#foldexpr()",
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			tokyonight_style = "night",
			blamer_enabled = 1,
			copilot_no_tab_map = true,
		},
	},

	-- Default theme configuration
	default_theme = {
		diagnostics_style = { italic = true },
		-- Modify the color table
		colors = {
			fg = "#abb2bf",
		},
		plugins = { -- enable or disable extra plugin highlighting
			aerial = true,
			beacon = true,
			bufferline = true,
			dashboard = false,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	-- Disable AstroNvim ui features
	ui = {
		nui_input = true,
		telescope_select = true,
	},

	-- -- LuaSnip Options
	-- luasnip = {
	--   -- Add paths for including more VS Code style snippets in luasnip
	--   vscode_snippet_paths = {},
	--   -- Extend filetypes
	--   filetype_extend = {
	--     javascript = { "javascriptreact" },
	--   },
	-- },

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},
	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without lsp-installer
		servers = {
			-- "pyright"
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {},
		},
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = {
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Mapping data with "desc" stored directly by vim.keymap.set().
	--
	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	mappings = {
		n = {
			-- move throught tabs with numbers
			["<leader>b1"] = { ":BufferLineGoToBuffer 1<CR>", desc = "B1" },
			["<leader>b2"] = { ":BufferLineGoToBuffer 2<CR>", desc = "B2" },
			["<leader>b3"] = { ":BufferLineGoToBuffer 3<CR>", desc = "B3" },
			["<leader>b4"] = { ":BufferLineGoToBuffer 4<CR>", desc = "B4" },
			["<leader>b5"] = { ":BufferLineGoToBuffer 5<CR>", desc = "B5" },
			["<leader>b6"] = { ":BufferLineGoToBuffer 6<CR>", desc = "B5" },
			["<leader>b7"] = { ":BufferLineGoToBuffer 7<CR>", desc = "B7" },
			["<leader>b8"] = { ":BufferLineGoToBuffer 8<CR>", desc = "B8" },
			["<leader>b9"] = { ":blast<CR>", desc = "BLast" },
			["<leader>bb"] = { ":tabnew<CR>", desc = "New tab" },
			["<leader>bc"] = { ":Bdelete<CR>", desc = "Close current tab" },
			["<leader>bj"] = { ":BufferLinePick<CR>", desc = "Pick to jump" },
			["<leader>bt"] = { ":BufferLineSortByTabs<CR>", desc = "Sort by tabs" },

			["<leader>a"] = { ":AerialToggle<CR>", desc = "Toggle Aerial" },

			["<A-k>"] = { ":m .-2<CR>==", desc = "Move line to the line above" },
			["<A-j>"] = { ":m .+1<CR>==", desc = "Move line to the line below" },
		},
		v = {
			["<A-k>"] = { ":m '<-2<CR>gv-gv", desc = "Move line/s to the line/s above" },
			["<A-j>"] = { ":m '>+1<CR>gv-gv", desc = "Move line/s to the line/s below" },
		},
		i = {
			["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line to the line above" },
			["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line to the line below" },
			["<C-S>"] = { "<cmd>w<CR>", desc = "Save" },
			["<C-J>"] = { "<cmd>k" }, -- <silent><script><expr> <C-J> copilot#Accept("\<CR>")
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},
	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
	end,
}

return config
