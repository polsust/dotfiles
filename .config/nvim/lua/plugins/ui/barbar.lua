return {
  enabled = true,
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  version = "^1.0.0",
  init = function() vim.g.barbar_auto_setup = false end,
  lazy = false,
  event = "VeryLazy",
  keys = {
    -- Move to previous/next
    { "<S-h>", "<Cmd>BufferPrevious<CR>" },
    { "<S-l>", "<Cmd>BufferNext<CR>" },

    -- Re-order to previous/next
    -- { "<M-<>", "<Cmd>BufferMovePrevious<CR>" }, -- they don't work
    -- { "<M->>", "<Cmd>BufferMoveNext<CR>" },

    -- Goto buffer in position...
    { "<M-1>", "<cmd>BufferGoto 1<cr>" },
    { "<M-2>", "<cmd>BufferGoto 2<cr>" },
    { "<M-3>", "<cmd>BufferGoto 3<cr>" },
    { "<M-4>", "<cmd>BufferGoto 4<cr>" },
    { "<M-5>", "<cmd>BufferGoto 5<cr>" },
    { "<M-6>", "<cmd>BufferGoto 6<cr>" },
    { "<M-7>", "<cmd>BufferGoto 7<cr>" },
    { "<M-8>", "<cmd>BufferGoto 8<cr>" },
    { "<M-9>", "<cmd>BufferLast<cr>" },

    -- Pin/unpin buffer
    { "<leader>pp", "<Cmd>BufferPin<CR>" },

    -- Goto pinned/unpinned buffer
    --                 :BufferGotoPinned
    --                 :BufferGotoUnpinned

    -- Close buffer
    -- { "<leader>c", "<Cmd>BufferClose<CR>" },
  },
  opts = {
    animation = false,

    auto_hide = 0,
    no_name_title = nil,

    exclude_ft = { "" },
    exclude_name = { "" },

    icons = {
      buffer_index = false,
      buffer_number = false,
      button = "",
      -- gitsigns = {
      --   added = { enabled = true, icon = "+" },
      --   changed = { enabled = true, icon = "~" },
      --   deleted = { enabled = true, icon = "-" },
      -- },
      separator_at_end = true,

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = { button = "●" },
      pinned = { button = "󰐃", filename = true },

      -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
      preset = "default",

      inactive = { button = "" },
    },
  },
}
