return {
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    keys = {
      { "F", function() require("hop").hint_words() end },
      -- { "F", function() require("hop").hint_patterns() end },
    },
  },
}
