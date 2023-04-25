-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    -- vim.opt_local.spell = true
  end,
})

-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Relative numbers only for normal mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- Relative numbers only for normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- -- special files lsp
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function()
-- 		local file_name = vim.api.nvim_buf_get_name(0)
-- 		if not ifle_name:find("style.js") then
-- 			return
-- 		end
-- 		local clients = vim.lsp.get_active_clients({ buffer = 0 })
-- 		-- do something ..
-- 	end,
-- })

-- open nvim-tree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end

    -- change to the directory
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})

-- autosave
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function(data)
    -- this will affect also any file which it's path contains spectre
    if string.find(data.file, "spectre") or data.file == "" then
      return
    end

    if vim.fn.getbufvar(data.buf, "&modifiable") == 1 then
      vim.cmd([[ silent write ]])
    end
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "SessionLoadPost",
  desc = "open nvim tree",
  callback = function()
    -- use this instead of .open() bc else it would select the tree split
    require("nvim-tree.api").tree.toggle(false, true)
  end,
})
