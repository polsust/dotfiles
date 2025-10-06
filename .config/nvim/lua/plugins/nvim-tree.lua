return {
  "nvim-tree/nvim-tree.lua",
  version = "*", lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<M-e>", "<cmd>NvimTreeToggle<CR>" },
  },
  opts = function()
    local on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function open_file_and_stay_in_tree()
        local node = api.tree.get_node_under_cursor()
        if node then
          api.node.open.edit(node)
          vim.cmd("NvimTreeOpen")
        end
      end

      -- BEGIN_DEFAULT_ON_ATTACH
      local opts = function(desc) return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))

      vim.keymap.set("n", "o", open_file_and_stay_in_tree, opts("Open File and Stay in Tree"))
      vim.keymap.set("n", "<C-o>", open_file_and_stay_in_tree, opts("Open File and Stay in Tree"))

      vim.keymap.set("n", "<leader>gk", api.node.navigate.git.prev, opts("Prev Git"))
      vim.keymap.set("n", "<leader>gj", api.node.navigate.git.next, opts("Next Git"))
      vim.keymap.set("n", "<leader>G", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))

      vim.keymap.set("n", "glk", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
      vim.keymap.set("n", "glj", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))

      vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
      vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
      vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
      vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
      vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
      vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
      vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
      vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
      vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
      vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
      vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
      vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
      vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
      vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
      vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
      vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
      vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
      vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
      vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
      vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
      vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
      vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
      vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
      vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
      vim.keymap.set("n", "q", api.tree.close, opts("Close"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
      vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
      vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
      vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
      vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
      vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
      vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
      vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
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
