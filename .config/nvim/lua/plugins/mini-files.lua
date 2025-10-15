return {
  enabled = true,
  "nvim-mini/mini.files",
  dependencies = "nvim-tree/nvim-web-devicons",
  version = false,
  lazy = false,
  keys = {
    {
      "<M-e>",
      function()
        if not MiniFiles.close() then
          local path = vim.api.nvim_buf_get_name(0)
          MiniFiles.open(path, false)
        end
      end,
    },
  },
  opts = {
    content = {
      -- Predicate for which file system entries to show
      filter = function(file)
        local patterns = { "^%.git$", "%.gd%.uid$", "^%.null%-ls" }

        local function matches_any(str)
          for _, pat in ipairs(patterns) do
            if str:match(pat) then
              return true
            end
          end
          return false
        end

        return not matches_any(file.name)
      end,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- In which order to show file system entries
      sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "l",
      go_out = "h",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = "<BS>",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "<c-s>",
      trim_left = "<",
      trim_right = ">",
    },

    -- General options
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = false,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
    },

    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 65,
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    ---@module 'snacks'
    if Snacks then
      local pick = Snacks.picker.pick
      ---@type fun(source?: string, opts?: snacks.picker.Config)
      Snacks.picker.pick = function(source, opts) ---@diagnostic disable-line
        MiniFiles.close()
        return pick(source, opts)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "mason", "lazy", "grapple" },
      callback = function()
        local win = vim.fn.win_getid()
        MiniFiles.close()
        vim.fn.win_gotoid(win)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowOpen",
      callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        vim.wo[win_id].winblend = 5
        local config = vim.api.nvim_win_get_config(win_id)

        config.border, config.title_pos = "single", "left"

        vim.api.nvim_win_set_config(win_id, config)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesExplorerOpen",
      callback = function() MiniFiles.reveal_cwd() end,
    })

    local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
    local autocmd = vim.api.nvim_create_autocmd
    local _, MiniFiles = pcall(require, "mini.files")

    -- Cache for git status
    local gitStatusCache = {}
    local cacheTimeout = 0 -- in milliseconds
    local uv = vim.uv or vim.loop

    local function isSymlink(path)
      local stat = uv.fs_lstat(path)
      return stat and stat.type == "link"
    end

    ---@type table<string, {symbol: string, hlGroup: string}>
    ---@param status string
    ---@return string symbol, string hlGroup

    vim.api.nvim_set_hl(0, "GitIgnored", { fg = "#9399B2", italic = true })
    vim.api.nvim_set_hl(0, "GitUntracked", { fg = "#F5C2E7" })

    local function mapSymbols(status, is_symlink)
      local statusMap = {
    -- stylua: ignore start 
    [" M"] = { symbol = "•", hlGroup  = "MiniDiffSignChange"}, -- Modified in the working directory
    ["M "] = { symbol = "✹", hlGroup  = "MiniDiffSignChange"}, -- modified in index
    ["MM"] = { symbol = "≠", hlGroup  = "MiniDiffSignChange"}, -- modified in both working tree and index
    ["A "] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   }, -- Added to the staging area, new file
    ["AA"] = { symbol = "≈", hlGroup  = "MiniDiffSignAdd"   }, -- file is added in both working tree and index
    ["D "] = { symbol = "", hlGroup  = "MiniDiffSignDelete"}, -- Deleted from the staging area
    ["AM"] = { symbol = "⊕", hlGroup  = "MiniDiffSignChange"}, -- added in working tree, modified in index
    ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange"}, -- Added in the index and deleted in the working directory
    ["R "] = { symbol = "➜", hlGroup  = "MiniDiffSignChange"}, -- Renamed in the index
    ["U "] = { symbol = "", hlGroup  = "MiniDiffSignChange"}, -- Unmerged path
    ["UU"] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged
    ["UA"] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged and added in working tree
    ["??"] = { symbol = "", hlGroup  = "GitUntracked"}, -- Untracked files
    [" D"] = { symbol = "", hlGroup  = "GitUntracked"}, -- Untracked files
    ["!!"] = { symbol = "◌", hlGroup  = "GitIgnored"}, -- Ignored files
      }

      local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
      if result.symbol == "?" then
        print(status)
      end
      local gitSymbol = result.symbol
      local gitHlGroup = result.hlGroup

      local symlinkSymbol = is_symlink and "↩" or ""

      -- Combine symlink symbol with Git status if both exist
      local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub("^%s+", ""):gsub("%s+$", "")
      -- Change the color of the symlink icon from "MiniDiffSignDelete" to something else
      local combinedHlGroup = is_symlink and "MiniDiffSignDelete" or gitHlGroup

      return combinedSymbol, combinedHlGroup
    end

    ---@param cwd string
    ---@param callback function
    ---@return nil
    local function fetchGitStatus(cwd, callback)
      local clean_cwd = cwd:gsub("^minifiles://%d+/", "")
      ---@param content table
      local function on_exit(content)
        if content.code == 0 then
          callback(content.stdout)
          -- vim.g.content = content.stdout
        end
      end
      ---@see vim.system
      vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = clean_cwd }, on_exit)
    end

    ---@param buf_id integer
    ---@param gitStatusMap table
    ---@return nil
    local function updateMiniWithGit(buf_id, gitStatusMap)
      vim.schedule(function()
        local nlines = vim.api.nvim_buf_line_count(buf_id)
        local cwd = vim.fs.root(buf_id, ".git")
        local escapedcwd = cwd and vim.pesc(cwd)
        escapedcwd = vim.fs.normalize(escapedcwd)

        for i = 1, nlines do
          local entry = MiniFiles.get_fs_entry(buf_id, i)
          if not entry then
            break
          end
          local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
          local status = gitStatusMap[relativePath]

          if status then
            local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
            vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
              sign_text = symbol,
              sign_hl_group = hlGroup,
              priority = 2,
            })
            -- This below code is responsible for coloring the text of the items. comment it out if you don't want that
            local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
            -- Find the name position accounting for potential icons
            local nameStartCol = line:find(vim.pesc(entry.name)) or 0

            if nameStartCol > 0 then
              vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
                end_col = nameStartCol + #entry.name - 1,
                hl_group = hlGroup,
              })
            end
          else
          end
        end
      end)
    end

    -- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
    ---@param content string
    ---@return table
    local function parseGitStatus(content)
      local gitStatusMap = {}
      -- lua match is faster than vim.split (in my experience )
      for line in content:gmatch("[^\r\n]+") do
        local status, filePath = string.match(line, "^(..)%s+(.*)")
        -- Split the file path into parts
        local parts = {}
        for part in filePath:gmatch("[^/]+") do
          table.insert(parts, part)
        end
        -- Start with the root directory
        local currentKey = ""
        for i, part in ipairs(parts) do
          if i > 1 then
            -- Concatenate parts with a separator to create a unique key
            currentKey = currentKey .. "/" .. part
          else
            currentKey = part
          end
          -- If it's the last part, it's a file, so add it with its status
          if i == #parts then
            gitStatusMap[currentKey] = status
          else
            -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
            if not gitStatusMap[currentKey] then
              gitStatusMap[currentKey] = status
            end
          end
        end
      end
      return gitStatusMap
    end

    ---@param buf_id integer
    ---@return nil
    local function updateGitStatus(buf_id)
      if not vim.fs.root(buf_id, ".git") then
        return
      end
      local cwd = vim.fs.root(buf_id, ".git")
      -- local cwd = vim.fn.expand("%:p:h")
      local currentTime = os.time()

      if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
        updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
      else
        fetchGitStatus(cwd, function(content)
          local gitStatusMap = parseGitStatus(content)
          gitStatusCache[cwd] = {
            time = currentTime,
            statusMap = gitStatusMap,
          }
          updateMiniWithGit(buf_id, gitStatusMap)
        end)
      end
    end

    ---@return nil
    local function clearCache() gitStatusCache = {} end

    local function augroup(name) return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true }) end

    autocmd("User", {
      group = augroup("start"),
      pattern = {
        "MiniFilesExplorerOpen",
        "MiniFilesActionCreate",
        "MiniFilesActionDelete",
        "MiniFilesActionRename",
        "MiniFilesActionCopy",
        "MiniFilesActionMove",
      },
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        updateGitStatus(bufnr)
      end,
    })

    autocmd("User", {
      group = augroup("close"),
      pattern = "MiniFilesExplorerClose",
      callback = function() clearCache() end,
    })

    autocmd("User", {
      group = augroup("update"),
      pattern = "MiniFilesBufferUpdate",
      callback = function(args)
        local bufnr = args.data.buf_id
        local cwd = vim.fs.root(bufnr, ".git")
        if gitStatusCache[cwd] then
          updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
        end
      end,
    })
  end,
}
