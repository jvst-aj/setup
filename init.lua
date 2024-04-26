-- NOTE: INSTALL LAZY PACKAGE MANAGER
-- See more: https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- Plugin Language for parsers (syntax highlighting)
	-- See more: https://github.com/nvim-treesitter/nvim-treesitter
	-- Installation: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
	{
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
	},

	-- Plugin for LSPs
	-- Mason allows to install LSPs
	-- See more: https://github.com/williamboman/mason.nvim
	-- Mason-LSPconfig plugin interface with Mason LSPconfig plugin to allow config LSPs on code instead of manual installing
	-- See more: https://github.com/williamboman/mason-lspconfig.nvim
	-- LSPconfig plugin allows Neovim to communicate with installed LSPs
	-- See more: https://github.com/neovim/nvim-lspconfig
	{
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
	},

	-- Plugin Nonels expose linters and formatters as an LSP so Neovim can communicate with these tools
	-- instead of use manually using some CLI
	-- See more: https://github.com/nvimtools/none-ls.nvim
	{
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
	},

	-- Plugin to autoformat
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }

				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
			},
		},
	},

	-- Plugins for autocompletion
	{
		-- See more: https://github.com/hrsh7th/nvim-cmp
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),

				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},

			"saadparwaiz1/cmp_luasnip",
			-- Adds other completion capabilities since nvim-cmp is split into multiple
			-- repos for maintenance purposes
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},

		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				completion = { completeopt = "menu,menuone,noinsert" },

				-- See :help ins-completion for mappings
				mapping = cmp.mapping.preset.insert({

					-- Select the next item
					["<M-j>"] = cmp.mapping.select_next_item(),

					-- Select the previous item
					["<M-k>"] = cmp.mapping.select_prev_item(),

					-- Accept the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Next snippet placeholder
					["<Tab>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),

					-- Previous snippet placeholder
					["<S-Tab>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),

				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Plugin Telescope Fuzzy Finder
	-- See more: https://github.com/nvim-telescope/telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				-- build is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- cond is a condition used to determine whether this plugin should be installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},

	-- Improves any select menus with Telescope one
	-- See more: https://github.com/nvim-telescope/telescope-ui-select.nvim
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},

	-- Plugin to show Git signs in the gutter
	-- See :help gitsigns
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Plugin to comment visual regions/lines
	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},

	-- Plugin to autopair characters
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Plugin to highlight todo, notes, fix me, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
})

-- NOTE: LEADER GUIDE

-- NOTE: GLOBAL

local opts = { noremap = true, silent = true }

-- Set leader key
-- See :help mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set escape
vim.keymap.set("i", "jj", "<Esc>", opts)

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: WINDOW

-- Show mode (mode also shows on status line)
vim.opt.showmode = false

-- Enable mouse mode (to resize panels)
vim.opt.mouse = "a"

-- Set terminal UI colors
vim.opt.termguicolors = true

-- Set transparency
-- Set editor zoom level

-- NOTE: WINDOW: NAVIGATION

-- Set how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Split editor vertically
vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":split<CR>", opts)

-- Switch Panes
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd <CR>", opts)
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)

-- NOTE: EDITOR

-- Set the cursor shape to I-Beam with blinking on leaving Neovim
-- vim.cmd[[
--    augroup RestoreCursorShapeOnExit
--        autocmd!
--        autocmd VimLeave * lua vim.cmd("set guicursor=a:ver25-blinkon700")
--    augroup END
--]]

-- Set word wrap column
-- Set word wrap

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 22

-- Highlight matching parentheses, brackets, and braces
vim.opt.showmatch = true

-- Show line numbers
vim.opt.number = true

-- Numbers relative
vim.opt.relativenumber = true

-- Keep sign colum on by default
vim.opt.signcolumn = "yes"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Enable line wrapping
vim.opt.wrap = true

-- Translate tab to spaces
vim.opt.expandtab = true

-- Tab width
vim.opt.tabstop = 2

-- Automatically indent new lines based on the previous line
vim.opt.autoindent = true

-- Enable break indent
vim.opt.breakindent = true

-- Identation width
vim.opt.shiftwidth = 2

-- Provide more intelligent indentation behavior
vim.opt.smartindent = true

-- NOTE: EDITOR: NAVIGATION

-- Up
-- Defaults to 'k'
-- Down
-- Defaults to 'j'
-- Left
-- Defaults to 'h'
-- Right
-- Defaults to 'l'

-- Start of line
vim.keymap.set("n", "gh", "^", opts)
vim.keymap.set("v", "gh", "^", opts)

-- End of line
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("v", "gl", "$", opts)

-- Page up
vim.keymap.set("n", "gk", "22k", opts)
vim.keymap.set("v", "gk", "22k", opts)

-- Page down
vim.keymap.set("n", "gj", "22j", opts)
vim.keymap.set("v", "gj", "22j", opts)

-- Next word
vim.keymap.set("n", "<S-l>", "w", opts)
vim.keymap.set("v", "<S-l>", "w", opts)

-- Previous word
vim.keymap.set("n", "<S-h>", "b", opts)
vim.keymap.set("v", "<S-h>", "b", opts)

-- Move line up
vim.keymap.set("n", "<S-k>", "ddkP", opts)

-- Move line down
vim.keymap.set("n", "<S-j>", "ddp", opts)

-- Add line up
vim.keymap.set("n", "<S-o>", "<S-o><Esc>", opts)

-- Add line down
vim.keymap.set("n", "o", "o<Esc>", opts)

-- Select all
vim.keymap.set("n", "vaa", "ggVG", opts)

-- NOTE: EDITOR: COPY & PASTE

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Use system clipboard
-- See :help clipboard
vim.o.clipboard = "unnamedplus"

-- Paste
-- Defaults to 'p'

-- NOTE: EDITOR: FORMATTING

-- Format file
vim.keymap.set("n", "<Leader>ff", vim.lsp.buf.format, opts)

-- Indent
vim.keymap.set("n", ".", ">>", opts)
vim.keymap.set("v", ".", ">>", opts)

-- Outdent
vim.keymap.set("n", ",", "<<", opts)
vim.keymap.set("v", ",", "<<", opts)

-- Comment
-- vim.keymap.set("n", "tc", "gcc", opts)

-- NOTE: FILES

-- Save file
vim.keymap.set("n", "<Leader>w", ":w!<CR>", opts)

-- Quit file or close panel
vim.keymap.set("n", "<Leader>q", ":q<CR>", opts)

-- Force exit without save
vim.keymap.set("n", "<Leader>x", ":q!<CR>", opts)

-- Rename file
-- space rf

-- Save undo history
vim.opt.undofile = true

-- Undo
-- Defaults to 'u'

-- Redo
vim.keymap.set("n", "U", "<C-r>", opts)

-- NOTE: SEARCHING & REFACTORING

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- Enter search mode with '*' on normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local builtin = require("telescope.builtin")

-- Search by word
vim.keymap.set("n", "<leader>sw", builtin.grep_string)

-- Search in multiple files with grep
vim.keymap.set("n", "<Leader>sg", builtin.live_grep)

-- Search files
vim.keymap.set("n", "<Leader>sf", builtin.find_files)

-- Search open files
vim.keymap.set("n", "<Leader>so", builtin.buffers)

-- Search diagnostics
vim.keymap.set("n", "<leader>sd", builtin.diagnostics)

-- Search keymaps
vim.keymap.set("n", "<leader>sk", builtin.keymaps)

-- Search help
vim.keymap.set("n", "<leader>sh", builtin.help_tags)

-- Next occurence
-- Defaults to 'n'

-- Previous occurence
-- Defaults to 'N'

-- Find & Replace

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local builtin = require("telescope.builtin")
		local opts = { buffer = event.buf }

		-- Show options about the word under your cursor
		vim.keymap.set("n", "<Leader>o", vim.lsp.buf.hover, opts)

		-- Code action
		vim.keymap.set("n", "<Leader>.", vim.lsp.buf.code_action, opts)

		-- Rename symbol under your cursor
		vim.keymap.set("n", "<Leader>rs", vim.lsp.buf.rename, opts)

		-- Go to definition of the word under your cursor
		-- vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<Leader>gd", builtin.lsp_definitions, opts)

		-- Go to type definition of the word under your cursor.
		-- vim.keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<Leader>gt", builtin.lsp_type_definitions, opts)

		-- Go to declaration of the word under your cursor
		-- Useful when language allow forward declarations
		vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)

		-- Go to implementation of the word under your cursor
		-- vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<Leader>gi", builtin.lsp_implementations, opts)

		-- Find references for the word under your cursor.
		vim.keymap.set("n", "<Leader>gr", builtin.lsp_references, opts)

		-- Fuzzy find all the symbols in your current document.
		vim.keymap.set("n", "<Leader>ss", builtin.lsp_document_symbols, opts)

		-- Fuzzy find all the symbols in your current workspace.
		vim.keymap.set("n", "<Leader>sS", builtin.lsp_dynamic_workspace_symbols, opts)

		-- The following two autocommands are used to highlight references of the word under your cursor
		-- when your cursor rests there for a little while. When you move your cursor, the highlights will be cleared
		-- See :help CursorHold for information about when this is executed
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
	end,
})

-- Next suggestion

-- Previous suggestion

-- NOTE: EXPLORER

-- Open explorer
vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>")
