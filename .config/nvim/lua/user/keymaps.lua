-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<A-CR>", "A;<esc>", opts)
keymap("i", "<A-CR>", "<esc>A;",opts)

-- Normal --
-- Better splits navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("n", "<Leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<Leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<Leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<Leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<Leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<Leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<Leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<Leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<Leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<Leader>$", "<cmd>BufferLineGoToBuffer -1<CR>", opts)

-- Tabs
keymap("n", "<Leader>tn", "<cmd>tabnew<CR>", opts)
keymap("n", "<Leader>tc", "<cmd>tabclose<CR>", opts)
keymap("n", "<Leader>L", "<cmd>tabn<CR>", opts)
keymap("n", "<Leader>H", "<cmd>tabp<CR>", opts)

-- Clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<Leader>c", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<Leader>C", "<cmd>BufferLineGroupClose ungrouped<CR><cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Select all
-- keymap("n", "<C-a>", "ggVG", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Mixed --
-- save/quit
keymap("n", "<C-q>", "<cmd>q<CR>")
keymap("n", "<C-S>", "<cmd>w<CR>")
keymap("i", "<C-q>", "<cmd>q<CR>")
keymap("i", "<C-S>", "<cmd>w<CR>")

-- Move text
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)

-- Plugins --
keymap("n", "gs", "<cmd>ToggleAlternate<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope
-- keymap("n", "<C-t>", "<cmd>Telescope<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope git_status<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_bcommits<CR>", opts)
keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>gh", "<cmd>Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<CR>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
keymap("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gr", "<cmd>Gitsigns refresh<CR>", opts)

-- LSP
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Aerial
keymap("n", "<leader>a", "<cmd>AerialToggle<CR>", opts)

-- Terminal
local termCmd = "ToggleTerm direction=horizontal size=45"
keymap("n", "<C-\\>", "<cmd>" .. termCmd .. "<CR>", opts)
keymap("t", "<C-\\>", "<cmd>" .. termCmd .. "<CR>", opts)

-- Lazygit
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Harpoon
keymap("n", "<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<Leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
-- keymap("n", "<Leader>hl", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
-- keymap("n", "<Leader>hh", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")

keymap("n", "<a-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<a-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<a-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<a-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- spectre
keymap("n", "<leader>fr", "<cmd>lua require('spectre').open()<CR>", opts)

-- packer
keymap("n", "<leader>ps", "<cmd>PackerSync<CR>", opts)
