return {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<M-e>", "<cmd>NvimTreeToggle<CR>" },
  },
  opts = function()
    local on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "NvimTree_*",
        callback = function() api.tree.reload() end,
      })

      local function open_file_and_stay_in_tree()
        local node = api.tree.get_node_under_cursor()
        if node then
          api.node.open.edit(node)
          vim.cmd("NvimTreeOpen")
        end
      end

      -- BEGIN_DEFAULT_ON_ATTACH
      local opts = function(desc) return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

      key("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      key("n", "l", api.node.open.edit, opts("Open"))
      key("n", "<CR>", api.node.open.edit, opts("Open"))

      key("n", "o", open_file_and_stay_in_tree, opts("Open File and Stay in Tree"))
      key("n", "<C-o>", open_file_and_stay_in_tree, opts("Open File and Stay in Tree"))

      key("n", "<leader>gk", api.node.navigate.git.prev, opts("Prev Git"))
      key("n", "<leader>gj", api.node.navigate.git.next, opts("Next Git"))
      key("n", "<leader>G", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))

      key("n", "glk", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
      key("n", "glj", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))

      key("n", "<C-.>", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))

      key("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
      key("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
      key("n", "<C-k>", api.node.show_info_popup, opts("Info"))
      key("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
      key("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
      key("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
      key("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
      key("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      key("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
      key("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
      key("n", ".", api.node.run.cmd, opts("Run Command"))
      key("n", "-", api.tree.change_root_to_parent, opts("Up"))
      key("n", "a", api.fs.create, opts("Create"))
      key("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
      key("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
      key("n", "c", api.fs.copy.node, opts("Copy"))
      key("n", "d", api.fs.remove, opts("Delete"))
      key("n", "D", api.fs.trash, opts("Trash"))
      key("n", "E", api.tree.expand_all, opts("Expand All"))
      key("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
      key("n", "F", api.live_filter.clear, opts("Clean Filter"))
      key("n", "f", api.live_filter.start, opts("Filter"))
      key("n", "g?", api.tree.toggle_help, opts("Help"))
      key("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
      key("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
      key("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
      key("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
      key("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
      key("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
      key("n", "p", api.fs.paste, opts("Paste"))
      key("n", "P", api.node.navigate.parent, opts("Parent Directory"))
      key("n", "q", api.tree.close, opts("Close"))
      key("n", "r", api.fs.rename, opts("Rename"))
      key("n", "R", api.tree.reload, opts("Refresh"))
      key("n", "s", api.node.run.system, opts("Run System"))
      key("n", "S", api.tree.search_node, opts("Search"))
      key("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
      key("n", "W", api.tree.collapse_all, opts("Collapse"))
      key("n", "x", api.fs.cut, opts("Cut"))
      key("n", "y", api.fs.copy.filename, opts("Copy Name"))
      key("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
      key("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
      key("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
    end

    local function parse_date(s)
      -- Strip the extension (anything after last dot)
      local name_without_ext = s:match("^(.*)%.%w+$") or s
      -- Match dd-mm-yyyy exactly on the name without extension
      local day, month, year = name_without_ext:match("^(%d%d)%-(%d%d)%-(%d%d%d%d)$")
      if day and month and year then
        day = tonumber(day)
        month = tonumber(month)
        year = tonumber(year)
        if day >= 1 and day <= 31 and month >= 1 and month <= 12 then
          return { day = day, month = month, year = year }
        end
      end
      return nil
    end

    local function compare_dates(d1, d2)
      if d1.year ~= d2.year then
        return d1.year < d2.year
      elseif d1.month ~= d2.month then
        return d1.month < d2.month
      else
        return d1.day < d2.day
      end
    end

    local function natural_cmp(left, right)
      -- Directories first
      if left.type == "directory" and right.type ~= "directory" then
        return true
      elseif left.type ~= "directory" and right.type == "directory" then
        return false
      end

      local l_name = left.name:lower()
      local r_name = right.name:lower()

      -- Check if both are dates (ignoring extensions)
      local l_date = parse_date(l_name)
      local r_date = parse_date(r_name)
      if l_date and r_date then
        return compare_dates(l_date, r_date)
      end

      if l_name == r_name then
        return false
      end

      local i = 1
      while i <= #l_name and i <= #r_name do
        local l_char = l_name:sub(i, i)
        local r_char = r_name:sub(i, i)

        local l_num = l_name:sub(i):match("^(%d+)")
        local r_num = r_name:sub(i):match("^(%d+)")

        if l_num and r_num then
          l_num = tonumber(l_num)
          r_num = tonumber(r_num)
          if l_num ~= r_num then
            return l_num < r_num
          end
          i = i + #tostring(l_num)
        else
          if l_char ~= r_char then
            return l_char < r_char
          end
          i = i + 1
        end
      end

      return #l_name < #r_name
    end

    return {
      on_attach = on_attach,
      -- sort_by = "name",
      sort_by = function(nodes) table.sort(nodes, natural_cmp) end,
      view = {
        side = "left",
        width = 40,
        relativenumber = true,
      },
      renderer = {
        highlight_git = true,
        full_name = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            git = {
              unstaged = "",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "init.lua", "index.js", "index.ts" },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^\\.git$", "\\.gd\\.uid$", "^\\.null-ls" },
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        open_file = {
          quit_on_open = true,
          resize_window = true,
        },
      },
    }
  end,
}
