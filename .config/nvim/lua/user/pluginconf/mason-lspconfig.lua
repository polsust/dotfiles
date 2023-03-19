local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  if client.name == "sumneko_lua" or client.name == "tsserver" or client.name == "html" then
    client.server_capabilities.document_formatting = false
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<Leader>wl", function()
  -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  vim.keymap.set("n", "<Leader>lr", "<cmd>lua require('renamer').rename()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>la", "<cmd>lua require('cosmic-ui').code_actions()<CR>", bufopts)
  vim.keymap.set("v", "<Leader>la", "<cmd>lua require('cosmic-ui').range_code_actions()<cr>", bufopts)
  vim.keymap.set("n", "<Leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", bufopts)
  vim.keymap.set("n", "<Leader>ld", "<cmd>Telescope diagnostics<CR>", bufopts)
  vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.formatting, bufopts)
end

local function setup_lsp(server_name, extraopts)
  extraopts = extraopts or {}
  local setup_opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  for k, v in pairs(extraopts) do
    setup_opts[k] = v
  end

  lspconfig[server_name].setup(setup_opts)
end

mason_lspconfig.setup_handlers({
  function(server_name)
    setup_lsp(server_name)
  end,
  ["lua_ls"] = function()
    setup_lsp("lua_ls", {
      settings = require("user.lsp.settings.lua_ls"),
    })
  end,
  ["jsonls"] = function()
    setup_lsp("jsonls", {
      settings = require("user.lsp.settings.jsonls"),
    })
  end,
})
