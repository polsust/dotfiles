return {
  {
    enabled = true,
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    opts = {
      automatic_enable = true,
    },
    -- config = function(_,opts)
    --   require("mason-lspconfig").setup(opts)
    --
    --   -- it works like this but not the other way on the ./lsp/servername.lua
    --   vim.lsp.config['jsonls'] = {
    --     settings = {
    --       json = {
    --         schemas = require("schemastore").json.schemas(),
    --         validate = { enable = true },
    --       },
    --     },
    --   }
    --
    --
    --
    -- end,
  },
}

-- outside of mason
-- setup_lsp("gdscript")
