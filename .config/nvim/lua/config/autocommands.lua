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

-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function() vim.cmd("set formatoptions-=cro") end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.hl.on_yank({ higroup = "Visual", timeout = 200 }) end,
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

-- autosave
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function(data)
    if vim.g.autosave == false then
      return
    end

    if string.find(data.file, "__harpoon") then
      return
    end

    if string.find(data.file, "oil") then
      return
    end

    if string.find(data.file, "minifiles") then
      return
    end

    -- this will affect also any file which it's path contains spectre
    if string.find(data.file, "spectre") or data.file == "" then
      return
    end

    if string.find(data.file, "dap") or data.file == "" then
      return
    end

    if vim.fn.getbufvar(data.buf, "&modifiable") == 1 then
      vim.cmd([[ silent write ]])
    end
  end,
})

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification after file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function() vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, false, {}) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dotenv" },
  callback = function() vim.treesitter.language.register("bash", "dotenv") end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function()
    local fname = vim.fn.expand("%:t")
    if fname:match("^calcurse%-note") then
      vim.bo.filetype = "markdown"
    end
  end,
})

-- paths to check for project.godot file
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.expand("%:p:h")

-- iterate over paths and check
for _key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. "/server.pipe")
-- start server, if not already running
if is_godot_project and not is_server_running then
  vim.fn.serverstart(godot_project_path .. "/server.pipe")
end

-- PRINT SIGNS --
-- Define the sign once
vim.fn.sign_define("PrintSign", { text = "", texthl = "WarningMsg" })

-- List of regex patterns (Lua patterns, not PCRE)
local patterns = {
  "print",
  "console%.",
}

-- Collect comment lines using Tree-sitter
local function get_comment_lines(buf)
  local lang = vim.bo[buf].filetype
  local ok, parser = pcall(vim.treesitter.get_parser, buf, lang)
  if not ok then
    return {}
  end
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Try to load a query for comments
  local ok_q, query = pcall(vim.treesitter.query.parse, lang, "(comment) @c")
  if not ok_q or not query then
    return {}
  end

  local comments = {}
  for _, node in query:iter_captures(root, buf, 0, -1) do
    local srow, _, erow, _ = node:range()
    for l = srow, erow do
      comments[l + 1] = true
    end
  end
  return comments
end

-- Re-run whenever buffer changes
vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "BufWritePost" }, {
  callback = function(args)
    local buf = args.buf
    vim.fn.sign_unplace("printgroup", { buffer = buf })
    local comments = get_comment_lines(buf)

    for lnum = 1, vim.api.nvim_buf_line_count(buf) do
      if not comments[lnum] then
        local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
        for _, pat in ipairs(patterns) do
          if line:match(pat) then
            vim.fn.sign_place(0, "printgroup", "PrintSign", buf, { lnum = lnum })
            break
          end
        end
      end
    end
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function() format_file(vim.api.nvim_get_current_buf()) end,
})

-- From vim defaults.vim
-- ---
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- -- Make splits default to vsplit
-- vim.api.nvim_create_autocmd("WinNew", {
--   callback = function()
--     -- Skip if it's a floating window
--     if vim.api.nvim_win_get_config(0).relative ~= "" then return end
--     -- Move automatically created split to the far right
--     vim.cmd("wincmd L")
--   end,
-- })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)

    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. arg)
    end
  end,
})
