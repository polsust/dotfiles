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

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

    vim.keymap.set("n", "gla", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
    vim.keymap.set("n", "glS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
    vim.keymap.set("n", "gld", "<cmd>Telescope diagnostics<CR>", opts)
  end,
})
