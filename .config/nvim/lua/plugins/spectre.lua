return {
  enabled = true,
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>sr", function() require("spectre").toggle() end },
  },
}
