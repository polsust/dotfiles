return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufEnter",
    init = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")
    end,
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      scope = {
        enabled = true,
        show_start = true,
      },
    },
  },
}
