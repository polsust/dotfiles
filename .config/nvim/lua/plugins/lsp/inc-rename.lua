return {
  enabled = true,
  "smjonas/inc-rename.nvim",
  keys = {
    { "grn" },
  },
  opts = function()
    vim.keymap.set("n", "grn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })
    return {
      -- post_hook = function() vim.cmd("wa") end,
    }
  end,
}
