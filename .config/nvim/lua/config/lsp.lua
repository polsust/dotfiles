vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    source = true,
    header = "",
    -- prefix = "",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local opts = { noremap = true, silent = true, buffer = args.buf }

    vim.keymap.set("n", "gli", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "glk", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "glj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "glq", vim.diagnostic.setloclist, opts)

    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
  end,
})

-- servers not managed by mason
vim.lsp.enable("gdscript")
