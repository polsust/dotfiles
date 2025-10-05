return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
      { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>" },
      { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>" },
      { "<leader>gh", "<cmd>Gitsigns reset_hunk<CR>" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<CR>" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>" },
      { "<leader>gl", "<cmd>Gitsigns blame_line<CR>" },
      { "<leader>gr", "<cmd>Gitsigns refresh<CR>" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>" },
    },
  },
}
