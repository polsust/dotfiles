return {
  enabled = true,
  "nvim-mini/mini.surround",
  event = "VeryLazy",
  version = false,
  opts = {
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 2000,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = "<m-s>", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
      replace = "cs", -- Replace surrounding

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 999,

    -- Whether to respect selection typed
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = true,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    -- see `:h MiniSurround.config`.
    search_method = "cover",

    -- Whether to disable showing non-error feedback
    -- This also affects (purely informational) helper messages shown after
    -- idle time if user input is required.
    silent = false,
  },
}
