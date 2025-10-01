require("illuminate").configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    "regex",
    "lsp",
    "treesitter",
  },
  -- delay: delay in milliseconds
  delay = 0,
  filetypes_denylist = {
    "alpha",
    "NvimTree",
    "TelescopePrompt",
  },
})
-- vim.cmd([[hi def IlluminatedWordText gui=underline]])
