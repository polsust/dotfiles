return {
  enabled = true,
  "nvim-mini/mini.operators",
  version = false,
  event = "VeryLazy",
  opts = {
    evaluate = {
      prefix = "g=",
      func = nil,
    },
    exchange = {
      prefix = "gX",
      reindent_linewise = true,
    },
    multiply = {
      prefix = "gm",
      func = nil,
    },
    sort = {
      prefix = "gS",
      func = nil,
    },
    -- replace = {
    --   prefix = "gr",
    --   reindent_linewise = true,
    -- },
  },
}
