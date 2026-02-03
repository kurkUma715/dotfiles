-- ===== PACKER =====
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use("navarasu/onedark.nvim")
	use("windwp/nvim-autopairs")

	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- ===== THEME =====
require("onedark").setup({
	style = "warmer",
	transparent = false,
	term_colors = false,
	code_style = {
		comments = "none",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},
	colors = { white = "#ffffff" },
	highlights = {},
})
require("onedark").load()

-- ===== AUTOPAIRS =====
-- require("nvim-autopairs").setup({})

-- ===== NVIM-TREE =====
require("nvim-tree").setup({
	auto_reload_on_write = true,
	hijack_cursor = true,
	update_focused_file = { enable = true, update_cwd = true },
	view = { width = 30, side = "left" },
	renderer = {
		highlight_git = false,
		icons = { show = { git = false, folder = true, file = true, folder_arrow = true } },
	},
})

-- ===== OPTIONS =====
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cursorline = true 
vim.o.termguicolors = true
vim.o.syntax = "on"
vim.opt.clipboard = "unnamedplus"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.matchtime = 2
vim.cmd("filetype plugin indent on")

-- ===== KEYMAPS =====
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- INSERT
keymap("i", "jk", "<Esc>", opts)

-- NORMAL
keymap("n", "zz", "zz", opts)
keymap("n", "<leader>s", ":%s//g<Left><Left>", opts)

-- BUFFER
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bl", ":ls<CR>:b<Space>", opts)
keymap("n", "<leader>bt", ":tabnew<CR>", opts)

-- TABS
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<leader>tn", ":tabnext<CR>", opts)
keymap("n", "<leader>tp", ":tabprevious<CR>", opts)

-- WINDOW NAVIGATION
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- SPLITS
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>se", "<C-w>=", opts)
keymap("n", "<leader>sx", ":close<CR>", opts)

-- NVIM-TREE
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)

-- CLIPBOARD
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)

-- MISC
keymap("n", "<C-q>", ":bdelete<CR>", opts)
keymap("n", "<leader>h", ":set hlsearch!<CR>", opts)
