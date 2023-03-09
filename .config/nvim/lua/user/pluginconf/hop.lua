local hop = require("hop")
hop.setup({ keys = "etovxqpdygfblzhckisuran" })

local directions = require("hop.hint").HintDirection

vim.keymap.set("", "f", function()
  hop.hint_patterns()
end, { remap = true })

vim.keymap.set("", "F", function()
  hop.hint_words()
end, { remap = true })
