local grapple = require("grapple")

function GrappleTag()
  grapple.tag()

  vim.notify("Grapple tagged: " .. vim.fn.expand("%:t"))
end

function OpenAllTags()
  local tags = grapple.tags()
  if not tags or #tags == 0 then
    return
  end

  -- Open the first file and let everything attach properly
  vim.cmd("edit " .. vim.fn.fnameescape(tags[1].path))

  -- Add remaining files to the buffer list
  for i = 2, #tags do
    vim.cmd("badd " .. vim.fn.fnameescape(tags[i].path))
  end
end

vim.keymap.set("n", "<a-i>", GrappleTag)
vim.keymap.set("n", "<a-o>", OpenAllTags)

vim.keymap.set("n", "<a-h>", grapple.toggle_tags)

vim.keymap.set("n", "<a-j>", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<a-k>", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<a-l>", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<a-;>", "<cmd>Grapple select index=4<cr>")
vim.keymap.set("n", "<a-'>", "<cmd>Grapple select index=4<cr>")

for i = 1, 9 do
  vim.keymap.set("n", "<a-" .. i .. ">", "<cmd>Grapple select index=" .. i .. "<cr>")
end

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.defer_fn(OpenAllTags, 100) -- Delay by 100ms to allow for initialization
--   end,
-- })
