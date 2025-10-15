return {
  enabled = true,
  "cbochs/grapple.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    {
      "<M-i>",
      function()
        require("grapple").tag()
        vim.notify("Grapple tagged: " .. vim.fn.expand("%:t"))
      end,
    },
    {
      "<M-o>",
      function()
        miniFilesClose()

        local tags = require("grapple").tags()
        if not tags or #tags == 0 then
          return
        end

        -- Open the first file and let everything attach properly
        vim.cmd("edit " .. vim.fn.fnameescape(tags[1].path))

        -- Add remaining files to the buffer list
        for i = 2, #tags do
          vim.cmd("edit " .. vim.fn.fnameescape(tags[i].path))
          vim.cmd("BufferGoto 1")
        end
      end,
    },
    { "<M-h>", function() require("grapple").toggle_tags() end },
    {
      "<M-j>",
      function()
        miniFilesClose()
        require("grapple").select({ index = 1 })
      end,
    },
    {
      "<M-k>",
      function()
        miniFilesClose()
        require("grapple").select({ index = 2 })
      end,
    },
    {
      "<M-l>",
      function()
        miniFilesClose()
        require("grapple").select({ index = 3 })
      end,
    },
    {
      "<M-;>",
      function()
        miniFilesClose()
        require("grapple").select({ index = 4 })
      end,
    },
    {
      "<M-'>",
      function()
        miniFilesClose()
        require("grapple").select({ index = 5 })
      end,
    },
  },
  opts = {
    statusline = {
      -- active = "|%s|",
      inactive = " %s ",
    },
  },
}
