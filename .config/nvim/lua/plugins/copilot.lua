return {
  enabled = false,
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-f>", 'copilot#Accept("\\<CR>")', { expr = true, noremap = true, silent = true, replace_keycodes = false })
  end,
}
