return {
  enabled = true,
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>" },
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>" },
    { "<m-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
    { "<m-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
    { "<m-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
    { "<m-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
    { "<m-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
    { "<m-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
    { "<m-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
    { "<m-9>", "<cmd>BufferLineGoToBuffer 8<CR>" },
    { "<m-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      custom_filter = function(buf, buf_nums)
        -- vim.print(vim.bo[buf].ft)
        return vim.bo[buf].filetype ~= "oil"

        --
        -- return not vim.bo[buf].filetype == "help"
      end,
    },
  },
}
