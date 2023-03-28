local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_on_save = true

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics
local a = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    ---- pyhton ----
    d.flake8,
    f.blue,

    ---- webdev ----
    d.eslint_d.with({
      extra_args = function(params)
        local files = Ls(params.root)
        -- TODO: make this recursive

        local conf = false
        for _, file in pairs(files) do
          if string.find(file, ".eslintrc.*") then
            conf = true
          end
        end

        if not conf then
          -- return { "-c" }
        end
      end,
    }),
    a.eslint_d,

    f.prettierd.with({
      disabled_filetypes = { "json" }, -- its kinda bad, jsonls does it better
    }),
    d.stylelint,

    ---- lua ----
    -- d.selene,
    f.stylua,

    ---- php ----
    f.blade_formatter,
    -- f.phpcsfixer,

    ---- shells ----
    f.fish_indent,
    d.fish,
    f.shellharden,
    d.shellcheck,
  },
  -- Format on save
  on_attach = function(client, bufnr)
    if format_on_save == true then
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end
  end,
})
