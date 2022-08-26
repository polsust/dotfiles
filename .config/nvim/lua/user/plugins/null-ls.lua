local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local format_on_save = true

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		---- pyhton ----
		d.flake8,
		f.blue,

		---- webdev ----
		d.eslint,
		f.prettierd.with({
			disabled_filetypes = { "json" },
		}),
		f.stylelint,
		f.sqlfluff.with({
			extra_args = { "--dialect", "mysql" },
		}),

		---- lua ----
		d.selene,
		f.stylua,

		---- php ----
		f.blade_formatter,
		f.phpcsfixer,
		d.php,

		---- shells ----
		f.fish_indent,
		d.fish,
		f.shellharden,
		d.shellcheck,
	},

	-- Format on save
	on_attach = function(client, bufnr)
		if format_on_save == true then
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						vim.lsp.buf.formatting_sync(nil, 1200)
					end,
				})
			end
		end
	end,
})
