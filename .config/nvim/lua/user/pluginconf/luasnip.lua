local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/user/user-snippets" } })

luasnip.filetype_extend("javascript", { "javascriptreact" })
luasnip.filetype_extend("javascriptreact", { "javascript" })

luasnip.filetype_extend("typescriptreact", { "javascript", "javascriptreact" })
luasnip.filetype_extend("typescript", { "javascript" })
