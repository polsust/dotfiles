-- stylua: ignore start
vim.g.lsp_kind_icons = {
  Text = '',
  Method = '',
  Function = '󰊕',
  Constructor = '󰒓',
  Field = '󰜢',
  Variable = '󰆦',
  Class = '',
  Interface = '',
  Module = '󰕳',
  Property = '󰖷',
  Unit = '', -- 
  Value = '',
  Enum = '',
  Keyword = '󰌆',
  Snippet = '',
  Color = '󰏘',
  File = '󰈔',
  Reference = '󰬲',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '󰪚', -- 
  TypeParameter = '󰬛',
}
-- stylua: ignore end

vim.g.autosave = true

_G.format_file = function(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local filtered_clients = vim.iter(clients):filter(function(client) return client.name ~= "GitHub Copilot" end):totable()

  if #filtered_clients == 0 then
    return
  end

  -- print(vim.inspect(vim.iter(clients):map(function(client) return client.name end)))

  -- check if null-ls is available
  local null_ls_active = vim.iter(filtered_clients):any(function(client) return client.name == "null-ls" end)

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if null_ls_active then
        return client.name == "null-ls"
      else
        return client.supports_method("textDocument/formatting")
      end
    end,
  })
end
