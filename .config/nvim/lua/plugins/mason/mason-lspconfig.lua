return {
  enabled = true,
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  event = "VeryLazy",
  opts = {
    automatic_enable = true,
  },
}
