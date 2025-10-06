return {
  enabled = true,
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<C-\>]] },
    { "<C-g>", function() _LAZYGIT_TOGGLE() end, mode = { "n", "t" } },
    { [[<M-\>]], function() _ALT_TOGGLE() end, mode = { "n", "t" } },
  },
  version = "*",
  opts = function()
    function _G.set_terminal_keymaps()
      local opts = { noremap = true, buffer = 0 }

      vim.keymap.set("t", "<C-esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })
    function _LAZYGIT_TOGGLE() lazygit:toggle() end

    local alt = Terminal:new({
      size = 30,
      hidden = true,
      direction = "tab",
    })

    function _LAZYGIT_TOGGLE() lazygit:toggle() end
    function _ALT_TOGGLE() alt:toggle() end

    return {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
      },
    }
  end,
}
