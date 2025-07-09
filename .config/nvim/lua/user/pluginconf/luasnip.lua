local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/user/user-snippets" } })

luasnip.filetype_extend("javascript", { "javascriptreact" })
luasnip.filetype_extend("javascriptreact", { "javascript" })

luasnip.filetype_extend("typescriptreact", { "javascript", "javascriptreact" })
luasnip.filetype_extend("typescript", { "javascript" })

vim.keymap.set({ "i", "s" }, "<C-e>", function()
  vim.schedule(function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end)
  return ""
end, { expr = true, silent = true })
