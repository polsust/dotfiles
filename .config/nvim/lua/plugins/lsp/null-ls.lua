return {
  enabled = true,
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function()
    return {
      sources = {},
    }
  end,
}
