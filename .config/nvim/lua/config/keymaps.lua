-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.g.mapleader = " "

key({ "n", "i" }, "<D-`>", "`")

key("n", "<m-a>", "ggVG<C-o>")
key("n", "<m-d>", "ggVGd")
key("n", "<m-c>", "ggVGy<C-o>")
key("n", "<m-r>", "<cmd>mksession! /tmp/Session.vim | restart source /tmp/Session.vim<cr>")

key("n", "<m-CR>", "A;<esc>")
key("i", "<m-CR>", "<esc>A;")

-- Navigate visual lines
key("n", "k", "gk")
key("n", "j", "gj")

-- Tabs
key("n", "<Leader>tn", "<cmd>tabnew<CR>")
key("n", "<Leader>tc", "<cmd>tabclose<CR>")
key("n", "<Leader>L", "<cmd>tabn<CR>")
key("n", "<Leader>H", "<cmd>tabp<CR>")

-- Clear highlights
key("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better paste
key("v", "p", '"_dP')

-- Stay in indent mode
key("v", "<", "<gv")
key("v", ">", ">gv")

-- save/quit
key({ "n", "t", "i" }, "<C-q>", "<cmd>q<CR>")
key({ "n", "i" }, "<C-S>", "<cmd>w<CR>")

-- Move text
key("n", "<m-K>", ":m .-2<CR>==")
key("n", "<m-J>", ":m .+1<CR>==")
key("i", "<m-K>", "<Esc>:m .-2<CR>==gi")
key("i", "<m-J>", "<Esc>:m .+1<CR>==gi")
key("v", "<m-K>", ":m '<-2<CR>gv-gv")
key("v", "<m-J>", ":m '>+1<CR>gv-gv")

local function OpenAllGitPending()
  if not vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true" then
    vim.notify("Not inside a Git repository")
    return
  end

  local handle = io.popen("git ls-files --modified --others --exclude-standard")
  if not handle then
    return
  end

  local output = handle:read("*a")
  handle:close()

  for file in output:gmatch("[^\r\n]+") do
    if vim.fn.filereadable(file) == 1 then
      miniFilesClose()
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end
  end
end

key("n", "<m-g>", OpenAllGitPending)
