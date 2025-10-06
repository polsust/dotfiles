return {
  {
    enabled = true,
    "nfrid/markdown-togglecheck",
    dependencies = { "nfrid/treesitter-utils" },
    ft = { "markdown" },
    keys = {
      -- toggle checked / create checkbox if it doesn't exist
      { "<M-m>", function() require("markdown-togglecheck").toggle() end },
    },
  },
}
