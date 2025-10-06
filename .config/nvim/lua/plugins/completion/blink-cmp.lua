return {
  {
    enabled = true,
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "l3MON4D3/LuaSnip",
      "nvim-tree/nvim-web-devicons",
      { "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
      -- NOTE: EXTRA SOURCES
      "hrsh7th/cmp-calc",
      -- ?? "lukas-reineke/cmp-under-comparator",
    },
    version = "1.*",
    config = function(_, opts)
      local blink_cmp = require("blink.cmp")

      blink_cmp.setup(opts)

      -- Save original function
      local original_make_client_capabilities = vim.lsp.protocol.make_client_capabilities
      -- Override it
      vim.lsp.protocol.make_client_capabilities = function()
        local caps = original_make_client_capabilities()
        local blink_caps = blink_cmp.get_lsp_capabilities()
        return vim.tbl_deep_extend("force", caps, blink_caps)
      end
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-o>"] = { "show_and_insert", "select_and_accept", "fallback" },

        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },

        ["<C-u>"] = { function(cmp) cmp.select_prev({ jump_by = "source_id" }) end },
        ["<C-d>"] = { function(cmp) cmp.select_next({ jump_by = "source_id" }) end },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" }, -- this conflicts with copilot completion

        ["<C-n>"] = { "snippet_forward" },
        ["<C-p>"] = { "snippet_backward" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = true,
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
        ghost_text = {
          -- not sure I want this
          enabled = false,
        },
        documentation = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        accept = {
          -- Write completions to the `.` register
          dot_repeat = true,
          -- Create an undo point when accepting a completion item
          create_undo_point = true,
          -- How long to wait for the LSP to resolve the item with additional information before continuing as-is
          resolve_timeout_ms = 100,
          auto_brackets = {
            -- Whether to auto-insert brackets for functions
            enabled = true,
            -- Default brackets to use for unknown languages
            default_brackets = { "(", ")" },
          },
        },

        menu = {
          border = "none",
          draw = {
            columns = {
              { "kind_icon", gap = 2, "kind" },
              { "label", "label_description", gap = 1, "item_source" },
            },
            components = {
              item_source = {
                text = function(ctx) return string.format("[%s]", ctx.source_name) end,
              },
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = vim.g.lsp_kind_icons[ctx.kind]
                  end

                  -- print(vim.inspect(ctx))
                  -- .. string.format("[%s]", ctx.source_name)
                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  local hl = ctx.kind_hl

                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end

                  return hl
                end,
              },
            },
          },
        },
      },
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = {
          "calc",
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },

          calc = {
            name = "calc",
            module = "blink.compat.source",
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },

      cmdline = {
        keymap = {
          preset = "inherit",
          -- ["<CR>"] = { "select_accept_and_enter", "fallback" },
        },
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
