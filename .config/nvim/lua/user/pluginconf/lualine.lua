local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local wtf = require("wtf")

require("lualine").setup({
  sections = {
    lualine_x = { wtf.get_status },
  },
})
