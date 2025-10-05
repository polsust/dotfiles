local function left() require("smart-splits").move_cursor_left() end
local function right() require("smart-splits").move_cursor_right() end
local function up() require("smart-splits").move_cursor_up() end
local function down() require("smart-splits").move_cursor_down() end

return {
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      { "<C-S-h>", function() require("smart-splits").resize_left() end, mode = { "n", "t" } },
      { "<C-S-j>", function() require("smart-splits").resize_down() end, mode = { "n", "t" } },
      { "<C-S-k>", function() require("smart-splits").resize_up() end, mode = { "n", "t" } },
      { "<C-S-l>", function() require("smart-splits").resize_right() end, mode = { "n", "t" } },
      { "<C-h>", left },
      { "<C-j>", down },
      { "<C-k>", up },
      { "<C-l>", right },
      {
        "<C-w>h",
        function()
          require("smart-splits").swap_buf_left()
          left()
        end,
      },
      {
        "<C-w>j",
        function()
          require("smart-splits").swap_buf_down()
          down()
        end,
      },
      {
        "<C-w>k",
        function()
          require("smart-splits").swap_buf_up()
          up()
        end,
      },
      {
        "<C-w>l",
        function()
          require("smart-splits").swap_buf_right()
          right()
        end,
      },
    },
    opts = {
      ignored_buftypes = { "nofile", "quickfix", "prompt" },
      ignored_filetypes = { "NvimTree" },
      default_amount = 3,
      at_edge = "stop",
      float_win_behavior = "previous",
      move_cursor_same_row = false,
      cursor_follows_swapped_bufs = false,
      ignored_events = { "BufEnter", "WinEnter" },
      log_level = "info",
    },
  },
}
