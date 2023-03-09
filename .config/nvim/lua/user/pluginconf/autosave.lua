-- local status_ok, autosave = pcall(require, "autosave")
-- if not status_ok then
--   return
-- end

local filters = require("autosave.filters")
-- Available filters:
-- filters.git_repo
-- filters.invert
-- filters.opt
-- filters.not_empty
-- filters.modifiable
-- filters.writeable
-- filters.modified
-- filters.filetype
-- filters.custom
-- Each filter has luadoc to describe its functionality and usage.
require("autosave").setup({
  plugin = {
    force = false, -- Whether to forcefully write or not (:w!)
  },
  events = {
    trigger_autocmds = false, -- Should
    register = true, -- Should autosave register its autocommands
    triggers = { -- The autocommands to register, if enabled
      "InsertLeave",
      "TextChanged",
    },
  },
  debounce = {
    enabled = true, -- Should debouncing be enabled
    delay = 250, -- If enabled, only save the file at most every `delay` ms
  },
  filters = { -- The filters to apply, see above for all options.
    -- These filters are required for basic operation as they prevent
    -- errors related to to buffer state.
    filters.writeable,
    filters.not_empty,
    filters.modified,
  },
  hooks = {
    on_enable = nil, -- Called when the plugin is enabled for the first time.
    pre_filter = nil, -- Called before the write sequence begins. (This happens before filter checks)
    pre_write = nil, -- Called before the buffer is written (This happens after all checks pass)
    post_write = nil, -- Called after the write sequence. (This happens after the buffer has been saved)
  },
})
