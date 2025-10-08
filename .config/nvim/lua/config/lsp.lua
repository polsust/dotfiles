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

key("n", "<leader>li", "<cmd>LspInfo<cr>")
key("n", "<leader>lf", function() format_file(vim.api.nvim_get_current_buf()) end)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local opts = { noremap = true, buffer = args.buf }

    key("n", "gli", vim.diagnostic.open_float, opts)
    key("n", "glk", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    key("n", "glj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    key("n", "glq", vim.diagnostic.setloclist, opts)

    key("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    key("n", "ga", vim.lsp.buf.code_action, opts)
  end,
})

-- servers not managed by mason
vim.lsp.enable("gdscript")
