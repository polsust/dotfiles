return {
  {
    enabled = false,
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      -- { "<C-p>", "<cmd>Telescope find_files<CR>" },
      { "<leader>fW", "<cmd>Telescope live_grep<CR>" },
      { "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<CR>" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>" },
      { "<leader>fg", "<cmd>Telescope git_status<CR>" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>" },
      { "<leader>gc", "<cmd>Telescope git_bcommits<CR>" },
    },
    opts = function()
      local exclude_patterns = {
        -- general
        ".git",
        "dist",
        "build",
        ".build",
        ".debris",
        ".mypy*",
        "__pycache__",
        ".null-ls*",

        -- php
        "vendor",

        -- js
        "node_modules",
        ".next",
        "composer.lock",
        "package-lock.json",
        "yarn.lock",
        "documentation",

        -- Godot
        ".godot",
        "*.gd.uid",
        "addons",
      }

      ---@param cmd table
      ---@param exclude_arg string
      local function add_exclude_patterns(cmd, exclude_arg)
        for _, exclude_pattern in ipairs(exclude_patterns) do
          table.insert(cmd, exclude_arg)
          table.insert(cmd, exclude_pattern)
        end
        return cmd
      end

      return {
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-o>"] = function(prompt_bufnr)
                require("telescope.actions").select_default(prompt_bufnr)
                require("telescope.builtin").resume()
              end,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = function()
              local find_command = {
                "fd",
                "-t",
                "file",
                "-H",
                "-I",
              }
              return add_exclude_patterns(find_command, "-E")
            end,
          },
          -- live_grep = {
          --   additional_args = function()
          --     -- return { "--glob", "!{.git,dist,build,.build,.debris,.godot,vendor,node_modules,.next,composer.lock,package-lock.json,yarn.lock,documentation,addons,*.gd.uid" }
          --   end,
          -- },
          current_buffer_fuzzy_find = {
            sorting_strategy = "ascending",
          },
          colorscheme = {
            enable_preview = true,
          },
        },
      }
    end,
  },
}
