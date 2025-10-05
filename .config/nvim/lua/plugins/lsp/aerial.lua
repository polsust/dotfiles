return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {

      { "<leader>a", "<cmd>AerialToggle<CR>" },
    },
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter" },
      min_width = 28,
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      icons = vim.g.lsp_kind_icons,
    },
  },
}
