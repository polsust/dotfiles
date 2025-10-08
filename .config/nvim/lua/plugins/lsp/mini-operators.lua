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
      prefix = "ge",
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
    replace = {
      prefix = "",
      reindent_linewise = true,
    },
  },
}
