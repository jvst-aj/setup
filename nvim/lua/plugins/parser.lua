-- Plugin Language for parsers (syntax highlighting)
-- See more: https://github.com/nvim-treesitter/nvim-treesitter
-- Installation: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	opts = {
		-- Declare parsers for language support
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"gitignore",
			"markdown",
			"csv",
			"json",
			"yaml",
			"html",
			"css",
			"javascript",
			"typescript",
			"python",
		},

		-- Auto install parsers on demand if not declared
		auto_install = true,

		-- Enable highlighting
		highlight = { enable = true },

		-- Enable identing
		indent = { enable = true },
	},

	config = function()
		-- Prefer git instead of curl in order to improve connectivity in some environments
		require("nvim-treesitter.install").prefer_git = true
	end,
}
