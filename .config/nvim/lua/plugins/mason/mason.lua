return {
  enabled = true,
  "mason-org/mason.nvim",
  keys = {
    { "<leader>lI", "<cmd>Mason<cr>" },
  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },

      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "x",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
      },
    },
  },
}
