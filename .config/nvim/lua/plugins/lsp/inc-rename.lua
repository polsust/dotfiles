return {
  enabled = true,
  "smjonas/inc-rename.nvim",
  keys = {
    { "gR" },
  },
  opts = function()
    key("n", "gR", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })
    return {
      -- post_hook = function() vim.cmd("wa") end,
    }
  end,
}
