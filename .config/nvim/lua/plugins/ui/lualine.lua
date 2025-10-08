return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = function()
    local macro = {
      color = { fg = "#efc86b", gui = "bold" },
      function()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end
        return "Recording @" .. reg
      end,
    }

    local lsp = {
      icon = "  LSP:",
      function()
        local null_ls_clients = require("null-ls.sources").get_available(vim.bo.filetype)
        local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })

        local clients = vim.list_extend(lsp_clients, null_ls_clients)

        local seen = {}

        local client_names = vim
          .iter(clients)
          :filter(function(client)
            if seen[client.name] then
              return false
            end
            seen[client.name] = true
            return not (client.name == "null-ls" or client.name == "GitHub Copilot")
          end)
          :map(function(client) return "" .. client.name .. "," end)
          :join(" ")

        return client_names ~= "" and "[" .. client_names:sub(1, -2) .. "]" or "None"
      end,
    }

    return {
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          macro,
          "branch",
          "diff",
          "diagnostics",
          "grapple",
        },
        lualine_c = {
          "filename",
          lsp,
        },
        --
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      options = {
        globalstatus = true,
        refresh = {
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "CursorMoved",
            "CursorMovedI",
            "ModeChanged",
            "RecordingEnter",
            "RecordingLeave",
            "LspAttach",
            "LspDetach",
          },
        },
      },
    }
  end,
}
