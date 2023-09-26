local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
local actions = require("telescope.actions")

-- .*dist.*

local find_command = {
  "rg",
  "--files",
  "--hidden",
  "--no-ignore", -- no gitignore
}

local ignore_patterns = {
  -- general
  ".git",
  "dist",
  "build",
  ".build",
  ".debris",

  -- php
  "vendor",

  -- js
  "node_modules",
  ".next",
  "composer.lock",
  "package-lock.json",
  "yarn.lock",
}

for _, ignore_pattern in ipairs(ignore_patterns) do
  -- print(vim.inspect(#ignore_patterns + 1))
  table.insert(find_command, "--glob")
  table.insert(find_command, "!" .. ignore_pattern .. "")
end

telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
      },
    },
  },
  pickers = {
    find_files = {
      find_command = find_command,
    },
    current_buffer_fuzzy_find = {
      sorting_strategy = "ascending",
    },
  },
})

-- telescope.load_extension("aerial")
telescope.load_extension("persisted")
