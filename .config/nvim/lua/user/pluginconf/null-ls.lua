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
    -- d.mypy,
    -- f.blue,

    ---- webdev ----
    -- d.eslint_d.with({
    --   extra_args = function(params)
    --     local files = Ls(params.root)
    --     -- TODO: make this recursive
    --
    --     local conf = false
    --     for _, file in pairs(files) do
    --       if string.find(file, ".eslintrc.*") then
    --         conf = true
    --       end
    --     end
    --
    --     if not conf then
    --       -- return { "-c" }
    --     end
    --   end,
    -- }),

    require("none-ls.diagnostics.eslint_d").with({
      condition = function(utils)
        return utils.root_has_file({
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          ".eslintrc",
          ".eslintrc.json",
          ".eslintrc.js",
          ".eslintrc.yaml",
          ".eslintrc.yml",
        })
      end,
    }),

    -- require("none-ls.formatting.eslint_d"),
    -- require("none-ls.code_actions.eslint_d"),

    f.prettierd,
    d.stylelint,

    -- f.rustywind,

    ---- lua ----
    -- d.selene,
    f.stylua,

    ---- shells ----
    d.fish,
    f.shellharden,

    f.gdformat,
    d.gdlint,
  },
  -- Format on save
  on_attach = function(client, bufnr)
    if format_on_save == false then
      return
    end
    if not client.supports_method("textDocument/formatting") then
      return
    end

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(client)
            -- return client.name == "null-ls"
            return client.name ~= "ts_ls"
          end,
        })
      end,
    })
  end,
})
