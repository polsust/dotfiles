-- Auto install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | Lazy sync
  augroup end
]])

local plugins = {
  "wbthomason/packer.nvim", -- Have packer manage itself
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim",
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
  "akinsho/bufferline.nvim",
  "moll/vim-bbye",
  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",
  "ahmedkhalf/project.nvim",
  "lewis6991/impatient.nvim",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },
  "goolord/alpha-nvim",

  "CosmicNvim/cosmic-ui",
  "MunifTanjim/nui.nvim",

  "rmagatti/alternate-toggler",
  "karb94/neoscroll.nvim",
  "chentoast/marks.nvim",
  "norcalli/nvim-colorizer.lua",
  "ThePrimeagen/harpoon",
  -- Colorschemes
  "folke/tokyonight.nvim",
  "lunarvim/darkplus.nvim",
  -- cmp plugins
  "hrsh7th/nvim-cmp",        -- The completion plugin
  "hrsh7th/cmp-buffer",      -- buffer completions
  "hrsh7th/cmp-path",        -- path completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help", -- vscode-like info about current param on a function
  "lukas-reineke/cmp-under-comparator", -- sorting

  -- snippets
  "L3MON4D3/LuaSnip",            --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig",            -- enable LSP
  "williamboman/mason.nvim",          -- language server installer
  "williamboman/mason-lspconfig.nvim", -- language server installer
  "nvimtools/none-ls.nvim",           -- for formatters and linters
  "RRethy/vim-illuminate",
  "stevearc/aerial.nvim",

  -- Telescope
  "nvim-telescope/telescope.nvim",

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "nvim-treesitter/nvim-treesitter-context",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- DAP
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "ravenxrz/DAPInstall.nvim",

  "navarasu/onedark.nvim",
  "gpanders/editorconfig.nvim",
  "jwalton512/vim-blade",
  "b0o/SchemaStore.nvim",
  "filipdutescu/renamer.nvim",
  "stevearc/dressing.nvim",
  "olimorris/persisted.nvim",
  "nvim-pack/nvim-spectre",

  "tyru/open-browser.vim",
  "weirongxu/plantuml-previewer.vim",
  "aklt/plantuml-syntax",

  "elkowar/yuck.vim",

  "phaazon/hop.nvim",
  "ziontee113/color-picker.nvim",
  "Shatur/neovim-session-manager",
  "tiagovla/scope.nvim",
  -- use({ "github/copilot.vim" })
  "jackMort/ChatGPT.nvim",
  "Exafunction/codeium.vim",

  { "toppair/peek.nvim",               build = "deno task --quiet build:fast" },
  "jay-babu/mason-null-ls.nvim",
  { "catppuccin/nvim", name = "catppuccin" },

  {
    "nfrid/markdown-togglecheck",
    dependencies = { "nfrid/treesitter-utils" },
    ft = { "markdown" },
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
  {
    "nfrid/treesitter-utils",
    ft = { "markdown" },
  },
  {
    "phelipetls/jsonpath.nvim",
    ft = { "json" },
  },
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  },
  {
    "tpope/vim-surround",
  },
  {
    "rest-nvim/rest.nvim",
  },
}

require("lazy").setup(plugins)
