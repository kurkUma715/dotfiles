-- ===== PACKER =====
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/nvim-treesitter-context")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
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
vim.cmd("colorscheme onedark")
-- ===== TREESITTER =====
require("nvim-treesitter").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
})

-- ===== AUTOPAIRS =====
--require("nvim-autopairs").setup({ check_ts = true })

-- ===== LSP =====
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "clangd" } })

vim.lsp.config("clangd", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.server_capabilities.semanticTokensProvider then
			vim.lsp.semantic_tokens.start(bufnr, client.id)
		end
	end,
})

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

-- ===== CMP =====
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- ===== OPTIONS =====
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cursorline = false 
vim.o.termguicolors = false 
vim.o.syntax = "off"
vim.opt.clipboard = "unnamedplus"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.matchtime = 2
vim.cmd("filetype plugin indent on")

-- ===== KEYMAPS =====
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local lsp_keymap = vim.keymap.set

-- INSERT
keymap("i", "jk", "<Esc>", opts)

-- NORMAL
keymap("n", "zz", "zz", opts)
keymap("n", "<leader>s", ":%s//g<Left><Left>", opts)

-- LSP
lsp_keymap("n", "gd", vim.lsp.buf.definition, opts)
lsp_keymap("n", "gD", vim.lsp.buf.declaration, opts)
lsp_keymap("n", "gr", vim.lsp.buf.references, opts)
lsp_keymap("n", "gi", vim.lsp.buf.implementation, opts)
lsp_keymap("n", "K", vim.lsp.buf.hover, opts)
lsp_keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
lsp_keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
lsp_keymap("n", "<leader>f", vim.lsp.buf.format, opts)

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
