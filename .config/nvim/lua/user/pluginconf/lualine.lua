local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local wtf = require("wtf")

require("lualine").setup({
  sections = {
    lualine_x = {
      wtf.get_status,
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = {
          fg = "#ff9e64",
        },
      },
    },
  },
})
