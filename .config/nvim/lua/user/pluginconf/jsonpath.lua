-- show json path in the winbar
if vim.fn.exists("+winbar") == 1 then
  vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
end

-- send json path to clipboard
vim.keymap.set("n", "yp", function()
  path = require("jsonpath").get():sub(2)

  vim.fn.setreg("+", path)

  print(path .. " Copied!")
end, { desc = "copy json path", buffer = true })
