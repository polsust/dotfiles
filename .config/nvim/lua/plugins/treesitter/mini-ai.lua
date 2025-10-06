return {
  enabled = true,
  "nvim-mini/mini.ai",
  version = false,
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = function()
    local gen_spec = require("mini.ai").gen_spec

    return {
      custom_textobjects = {
        -- Tweak argument to be recognized only inside `()` between `;`
        a = gen_spec.argument({ brackets = { "%b()" }, separator = ";" }),

        -- Tweak function call to not detect dot in function name
        F = gen_spec.function_call({ name_pattern = "[%w_]" }),

        -- Function definition (needs treesitter queries with these captures)
        f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),

        -- c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

        -- Make `|` select both edges in non-balanced way
        ["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
      },
    }
  end,
}
