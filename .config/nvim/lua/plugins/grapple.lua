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
      "<a-i>",
      function()
        require("grapple").tag()
        vim.notify("Grapple tagged: " .. vim.fn.expand("%:t"))
      end,
    },
    {
      "<a-o>",
      function()
        local tags = require("grapple").tags()
        if not tags or #tags == 0 then
          return
        end

        -- Open the first file and let everything attach properly
        vim.cmd("edit " .. vim.fn.fnameescape(tags[1].path))

        -- Add remaining files to the buffer list
        for i = 2, #tags do
          vim.cmd("badd " .. vim.fn.fnameescape(tags[i].path))
        end
      end,
    },
    { "<a-h>", function() require("grapple").toggle_tags() end },
    { "<a-j>", "<cmd>Grapple select index=1<cr>" },
    { "<a-k>", "<cmd>Grapple select index=2<cr>" },
    { "<a-l>", "<cmd>Grapple select index=3<cr>" },
    { "<a-;>", "<cmd>Grapple select index=4<cr>" },
    { "<a-'>", "<cmd>Grapple select index=5<cr>" },
  },
  opts = {
    scope = "cwd",
  },
}
