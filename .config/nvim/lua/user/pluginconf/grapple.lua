local grapple = require("grapple")

vim.keymap.set("n", "<a-h>", grapple.toggle_tags)

vim.keymap.set("n", "<a-a>", function()
  grapple.tag()

  vim.notify("Grapple tagged: " .. vim.fn.expand("%:t"))
end)

vim.keymap.set("n", "<a-j>", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<a-k>", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<a-l>", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<a-;>", "<cmd>Grapple select index=4<cr>")

for i = 1, 9 do
  vim.keymap.set("n", "<a-" .. i .. ">", "<cmd>Grapple select index=" .. i .. "<cr>")
end
