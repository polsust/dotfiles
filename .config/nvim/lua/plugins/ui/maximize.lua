return {
  {
    "declancm/maximize.nvim",
    keys = {
      { "<M-f>", "<cmd>Maximize<cr>" },
    },
    opts = {
      {
        plugins = {
          aerial = { enable = true },
          dapui = { enable = true },
          tree = { enable = true },
        },
      },
    },
  },
}
