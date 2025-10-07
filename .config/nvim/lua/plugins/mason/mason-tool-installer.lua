return {
  enabled = true,
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      -- NOTE: LSP
      "lua-language-server",
      "typescript-language-server",
      "bash-language-server",
      "yaml-language-server",
      "tombi",
      "json-lsp",
      "fish-lsp",
      "pyright",
      "css-lsp",
      "tailwindcss-language-server",
      "marksman",
      "html-lsp",

      -- NOTE: DAP

      -- NOTE: FORMATTER/LINTER
      "shellharden",
      "shfmt",
      "eslint_d",
      "stylua",
      "prettierd",
      "gdtoolkit",
      "black",
    },
    auto_update = true,
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 10,
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = true,
      ["mason-nvim-dap"] = true,
    },
  },
}
