local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"
local format_on_save = true;

null_ls.setup {
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.completion.spell,
    ---- FORMATTING --
    null_ls.builtins.formatting.stylua, -- lua
    null_ls.builtins.formatting.fish_indent, -- fish
    null_ls.builtins.formatting.beautysh, -- sh
    null_ls.builtins.formatting.yapf, -- python
    null_ls.builtins.formatting.stylelint, -- scss, less, css, sass
    null_ls.builtins.formatting.prettier.with { -- web dev
      disabled_filetypes = { "json" },
    },
    null_ls.builtins.formatting.sqlfluff.with { -- sql
      extra_args = { "--dialect", "mysql" }, -- change to your dialect
    },
    -- DIAGNOSTICS --
    null_ls.builtins.diagnostics.fish -- fish
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
