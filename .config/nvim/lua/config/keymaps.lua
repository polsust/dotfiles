local key = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

key({ "n", "i" }, "<D-`>", "`")

key("n", "<m-a>", "ggVG<C-o>", opts)
key("n", "<m-d>", "ggVGd", opts)
key("n", "<m-c>", "ggVGy<C-o>", opts)
key("n", "<m-r>", "<cmd>mksession! Session.vim | restart source Session.vim<cr>", opts)

key("n", "<m-CR>", "A;<esc>", opts)
key("i", "<m-CR>", "<esc>A;", opts)

-- Navigate visual lines
key("n", "k", "gk", opts)
key("n", "j", "gj", opts)

-- Navigate buffers
key("n", "<S-l>", "<cmd>bnext<CR>", opts)
key("n", "<S-h>", "<cmd>bprevious<CR>", opts)
key("n", "<Leader>0", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
key("n", "<Leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
key("n", "<Leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
key("n", "<Leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
key("n", "<Leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
key("n", "<Leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
key("n", "<Leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
key("n", "<Leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
key("n", "<Leader>9", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
key("n", "<Leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", opts)
key("n", "<Leader>$", "<cmd>BufferLineGoToBuffer -1<CR>", opts)

-- Tabs
key("n", "<Leader>tn", "<cmd>tabnew<CR>", opts)
key("n", "<Leader>tc", "<cmd>tabclose<CR>", opts)
key("n", "<Leader>L", "<cmd>tabn<CR>", opts)
key("n", "<Leader>H", "<cmd>tabp<CR>", opts)

-- Clear highlights
key("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Better paste
key("v", "p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
key("v", "<", "<gv", opts)
key("v", ">", ">gv", opts)

-- Mixed --
-- save/quit
key({ "n", "t", "i" }, "<C-q>", "<cmd>q<CR>")
key({ "n", "i" }, "<C-S>", "<cmd>w<CR>")

-- Move text
key("n", "<m-K>", ":m .-2<CR>==", opts)
key("n", "<m-J>", ":m .+1<CR>==", opts)
key("i", "<m-K>", "<Esc>:m .-2<CR>==gi", opts)
key("i", "<m-J>", "<Esc>:m .+1<CR>==gi", opts)
key("v", "<m-K>", ":m '<-2<CR>gv-gv", opts)
key("v", "<m-J>", ":m '>+1<CR>gv-gv", opts)

-- LSP
key("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
key("n", "<leader>lf", function() format_file(vim.api.nvim_get_current_buf()) end)

-- plugins
key("n", "<leader>ps", "<cmd>Lazy sync<CR>", opts)

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
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end
  end
end

key("n", "<m-g>", OpenAllGitPending, opts)
