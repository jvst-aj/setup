-- Plugin for LSPs
-- Mason allows to install LSPs
-- See more: https://github.com/williamboman/mason.nvim
-- Mason-LSPconfig plugin interface with Mason LSPconfig plugin to allow config LSPs on code instead of manual installing
-- See more: https://github.com/williamboman/mason-lspconfig.nvim
-- LSPconfig plugin allows Neovim to communicate with installed LSPs
-- See more: https://github.com/neovim/nvim-lspconfig
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vimls",
					"bashls",
					"markdown_oxide",
					"jsonls",
					"yamlls",
					"html",
					"emmet_ls",
					"cssls",
					"cssmodules_ls",
					"tailwindcss",
					"tsserver",
					"eslint",
					"pyright",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Lua Language Server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			-- Bash Language Server
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})

			-- Markdown Language Server (Oxide)
			lspconfig.markdown_oxide.setup({
				capabilities = capabilities,
			})

			-- JSON Language Server
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

			-- YAML Language Server
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})

			-- HTML Language Server
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			-- Emmet Language Server
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
			})

			-- CSS Language Server
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			-- CSS Modules Language Server
			lspconfig.cssmodules_ls.setup({
				capabilities = capabilities,
			})

			-- Tailwind CSS Language Server
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})

			-- TypeScript Language Server
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			-- ESLint Language Server
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})

			-- Python Language Server
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
		end,
	},
}
