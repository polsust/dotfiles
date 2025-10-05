return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "vim",
        "regex",
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
      },
      auto_install = true,
      highlight = {
        enable = true,

        -- Setting this to true will run ":h syntax` and tree-sitter at the same time.
        -- Set this to "true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",

          node_incremental = "grn",
          node_decremental = "grN",

          scope_incremental = "grc",
        },
      },

      indent = {
        enable = true,
      },
    },
  },
}
