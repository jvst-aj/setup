-- Plugin Nonels expose linters and formatters as an LSP so Neovim can communicate with these tools
-- instead of use manually using some CLI
-- See more: https://github.com/nvimtools/none-ls.nvim
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua linter (commented since there is an error)
				--null_ls.builtins.diagnostics.luacheck,

				-- Lua formatter
				null_ls.builtins.formatting.stylua,

				-- Markdown linter
				null_ls.builtins.diagnostics.markdownlint,

				-- HTML linter (commented since there is an error)
				--null_ls.builtins.diagnostics.htmlhint,

				-- CSS linter
				null_ls.builtins.diagnostics.stylelint,

				-- Javascript / Typescript linter
				-- null_ls.builtins.diagnostics.eslint_d,

				-- JSON linter (commented since there is an error)
				--null_ls.builtins.diagnostics.jsonlint,

				-- YAML linter
				null_ls.builtins.diagnostics.yamllint,

				-- Markdown, HTML, CSS, Javascript, Typescript, JSX, TSX, JSON, YAML  formatter
				null_ls.builtins.formatting.prettier,

				-- Python linter
				null_ls.builtins.diagnostics.pylint,

				-- Python formatters
				null_ls.builtins.formatting.black,
				-- Sorts Python imports alphabetically
				null_ls.builtins.formatting.isort,

				null_ls.builtins.completion.spell,
			},
		})
	end,
}
