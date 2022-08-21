local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"
local format_on_save = true

null_ls.setup {
  sources = {
    ---- pyhton ----
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.blue,

    ---- webdev ----
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettierd.with {
      disabled_filetypes = { "json" },
    },
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.formatting.sqlfluff.with {
      extra_args = { "--dialect", "mysql" },
    },

    ---- lua ----
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.formatting.stylua,

    ---- shells ----
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.diagnostics.shellcheck,
  },

  -- Format on save
  on_attach = function(client, bufnr)
    if format_on_save == true then
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.formatting_sync()
          end,
        })
      end
    end
  end,
}
