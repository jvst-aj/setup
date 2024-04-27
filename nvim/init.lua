local map = vim.keymap.set

-- NOTE: GLOBAL

-- Set leader key
-- See :help mapleader

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set escape
map("i", "jj", "<Esc>")

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

require("lazy").setup("plugins")

-- NOTE: Load keymaps and options after plugins
require("config.keymaps")
require("config.options")
