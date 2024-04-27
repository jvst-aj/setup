-- NOTE: GLOBAL

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

-- NOTE: FILES

-- Save undo history
vim.opt.undofile = true

-- Undo
-- Defaults to 'u'

-- Redo
vim.keymap.set("n", "U", "<C-r>", opts)
