return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>fr", function() require("spectre").toggle() end },
    },
  },
}
