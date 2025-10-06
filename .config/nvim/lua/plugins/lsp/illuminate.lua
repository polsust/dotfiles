return {
  {
    enabled = true,
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 0,
        filetypes_denylist = {
          "alpha",
          "NvimTree",
          "TelescopePrompt",
        },
      })
    end,
  },
}
