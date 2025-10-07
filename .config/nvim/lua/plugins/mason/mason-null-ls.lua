return {
  enabled = true,
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  event = "VeryLazy",
  opts = {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
      eslint_d = function()
        local null_ls = require("null-ls")

        local function eslint_d_condition(utils)
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
        end

        null_ls.register(require("none-ls.diagnostics.eslint_d").with({
          condition = eslint_d_condition,
        }))

        null_ls.register(require("none-ls.code_actions.eslint_d").with({
          condition = eslint_d_condition,
        }))
      end,
    },
  },
}
