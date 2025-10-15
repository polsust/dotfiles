return {
  enabled = false,
  "stevearc/oil.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  keys = {
    { "-", "<CMD>Oil<CR>" },
  },
  opts = {
    default_file_explorer = true,
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    -- (:help prompt_save_on_select_new_entry)
    prompt_save_on_select_new_entry = true,
    -- Oil will automatically delete hidden buffers after this delay
    -- You can set the delay to false to disable cleanup entirely
    -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      -- Enable or disable LSP file operations
      enabled = true,
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 1000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = true,
    },
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or "name" to keep it on the file names
    constrain_cursor = "editable",
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,
    -- Keymaps in oil buffer. Can be any value that `key` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      -- ["<C-p>"] = "actions.preview",
      ["<C-q>"] = { "actions.close", mode = "n" },
      ["<C-r>"] = "actions.refresh",
      -- ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, _)
        local m = name:match("^%.")
        return m ~= nil
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, _)
        local patterns = { "^%.git$", "%.gd%.uid$", "^%.null%-ls" }

        local function matches_any(str)
          for _, pat in ipairs(patterns) do
            if str:match(pat) then
              return true
            end
          end
          return false
        end

        return matches_any(name)
      end,
      -- Sort file names with numbers in a more intuitive order for humans.
      -- Can be "fast", true, or false. "fast" will turn it off for large directories.
      natural_order = true,
      -- Sort file and directory names case insensitive
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
      -- Customize the highlight group for the file name
      highlight_filename = function() return nil end,
    },
    -- Extra arguments to pass to SCP when moving/copying files over SSH
    extra_scp_args = {},
    -- Configuration for the file preview window
    preview_win = {
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
      -- A function that returns true to disable preview on a file e.g. to avoid lag
      disable_preview = function() return false end,
      -- Window-local options to use for preview window buffers
      win_options = {},
    },
    -- Configuration for the floating action confirmation window
    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      -- border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      -- border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the floating keymaps help window
  },
}
