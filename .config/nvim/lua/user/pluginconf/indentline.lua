local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

local highlight = {
  "CursorColumn",
  "Whitespace",
}

indent_blankline.setup({

  -- indent = { highlight = highlight, char = "" },
  -- whitespace = {
  --   highlight = highlight,
  --   remove_blankline_trail = false,
  -- },
  scope = { enabled = true,
  show_start = true,
  },
})
