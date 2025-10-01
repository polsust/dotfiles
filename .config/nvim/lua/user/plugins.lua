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
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
  },
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
  "neovim/nvim-lspconfig", -- enable LSP
  { "mason-org/mason.nvim",           branch = "v1.x" },
  { "mason-org/mason-lspconfig.nvim", branch = "v1.x" },
  "RRethy/vim-illuminate",
  "stevearc/aerial.nvim",

  -- Telescope
  "nvim-telescope/telescope.nvim",

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "hiphish/rainbow-delimiters.nvim",
  "windwp/nvim-ts-autotag",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- DAP
  "mfussenegger/nvim-dap",
  { "rcarriga/nvim-dap-ui",            dependencies = { "nvim-neotest/nvim-nio" } },
  "theHamsta/nvim-dap-virtual-text",

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
  "tiagovla/scope.nvim",
  -- "github/copilot.vim",
  "Exafunction/codeium.vim",

  { "toppair/peek.nvim", build = "deno task --quiet build:fast" },
  "jay-babu/mason-null-ls.nvim",
  "jay-babu/mason-nvim-dap.nvim",

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  },

  { "catppuccin/nvim",   name = "catppuccin" },

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
    "echasnovski/mini.ai",
    version = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  { "cbochs/grapple.nvim" },
  { "mrjones2014/smart-splits.nvim" },
}

require("lazy").setup(plugins)

-- put this in your init.lua
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.yuck" },
  callback = function(event)
    -- print(string.format("starting yuck;s for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "YuckLs",
      cmd = { "yuckls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
