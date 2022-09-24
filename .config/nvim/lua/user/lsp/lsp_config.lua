local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
local status_lsp_config_ok, lsp_config = pcall(require, "lspconfig")
if not status_lsp_config_ok then
	return
end

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = true,
	signs = {
		active = signs, -- show signs
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<Leader>lk", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<Leader>lj", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>lq", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	if client.name == "sumneko_lua" or client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.rsl = false
		client.resolved_capabilities.include_text = false
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
	vim.keymap.set("n", "<Leader>lr", "<cmd>lua require('cosmic-ui').rename()<CR>", bufopts)
	vim.keymap.set("n", "<Leader>la", "<cmd>lua require('cosmic-ui').code_actions()<CR>", bufopts)
	vim.keymap.set("v", "<Leader>la", "<cmd>lua require('cosmic-ui').range_code_actions()<cr>", bufopts)
	vim.keymap.set("n", "<Leader>ls", "<cmd>Telescope treesitter<CR>", bufopts)
	vim.keymap.set("n", "<Leader>ld", "<cmd>Telescope diagnostics<CR>", bufopts)
	vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_lsp(server_name, extraopts)
	extraopts = extraopts or {}
	local setup_opts = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = lsp_flags,
	}

	for k, v in pairs(extraopts) do
		setup_opts[k] = v
	end

	lsp_config[server_name].setup(setup_opts)
end

-- LSP SERVERS
setup_lsp("sumneko_lua", {
	settings = require("user.lsp.settings.sumneko_lua"),
})
setup_lsp("tsserver")
setup_lsp("cssls", { filetypes = { "css", "sass", "scss", "style.js", "style.ts" } })
setup_lsp("pyright")
setup_lsp("html", { filetypes = { "html", "blade.php", "jsx", "tsx" } })
setup_lsp("intelephense")
setup_lsp("jsonls")
