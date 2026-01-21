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

	if packer_bootstrap then
		require("packer").sync()
	end
end)

require("onedark").setup({
	style = "dark",
	transparent = false,
	term_colors = true,
})
require("onedark").load()

require("nvim-treesitter").setup({
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd" },
})

vim.lsp.config("clangd", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.server_capabilities.semanticTokensProvider then
			vim.lsp.semantic_tokens.start(bufnr, client.id)
		end
	end,
})

require("nvim-tree").setup({
	auto_reload_on_write = true,
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		width = 30,
		side = "left",
	},
	renderer = {
		highlight_git = false,
		icons = {
			show = {
				git = false,
				folder = true,
				file = true,
				folder_arrow = true,
			},
		},
	},
})

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

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.syntax = "enable"
vim.opt.clipboard = "unnamedplus"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.matchtime = 2
vim.cmd("colorscheme onedark")
vim.cmd("filetype plugin indent on")

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local lsp_keymap = vim.keymap.set

-- ===== INSERT MODE =====
keymap("i", "jk", "<Esc>", opts) -- Быстрый выход в normal mode

-- ===== NORMAL MODE (базовые) =====
keymap("n", "zz", "zz", opts) -- Центрировать курсор
keymap("n", "<leader>s", ":%s//g<Left><Left>", opts) -- Поиск и замена по всему файлу

-- ===== LSP =====
lsp_keymap("n", "gd", vim.lsp.buf.definition, opts) -- Перейти к определению
lsp_keymap("n", "gD", vim.lsp.buf.declaration, opts) -- Перейти к объявлению
lsp_keymap("n", "gr", vim.lsp.buf.references, opts) -- Найти все ссылки
lsp_keymap("n", "gi", vim.lsp.buf.implementation, opts) -- Перейти к реализации
lsp_keymap("n", "K", vim.lsp.buf.hover, opts) -- Документация
lsp_keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Переименование
lsp_keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
lsp_keymap("n", "<leader>f", vim.lsp.buf.format, opts) -- Форматирование

-- ===== BUFFER =====
keymap("n", "<leader>bn", ":bnext<CR>", opts) -- Следующий буфер
keymap("n", "<leader>bp", ":bprevious<CR>", opts) -- Предыдущий буфер
keymap("n", "<leader>bd", ":bdelete<CR>", opts) -- Закрыть буфер
keymap("n", "<leader>bl", ":ls<CR>:b<Space>", opts) -- Список буферов
keymap("n", "<leader>bt", ":tabnew<CR>", opts) -- Новый таб

-- ===== TABS =====
keymap("n", "<leader>tc", ":tabclose<CR>", opts) -- Закрыть таб
keymap("n", "<leader>tn", ":tabnext<CR>", opts) -- Следующий таб
keymap("n", "<leader>tp", ":tabprevious<CR>", opts) -- Предыдущий таб

-- ===== WINDOW NAVIGATION =====
keymap("n", "<C-h>", "<C-w>h", opts) -- Окно влево
keymap("n", "<C-j>", "<C-w>j", opts) -- Окно вниз
keymap("n", "<C-k>", "<C-w>k", opts) -- Окно вверх
keymap("n", "<C-l>", "<C-w>l", opts) -- Окно вправо

-- ===== SPLITS =====
keymap("n", "<leader>sv", ":vsplit<CR>", opts) -- Вертикальный сплит
keymap("n", "<leader>sh", ":split<CR>", opts) -- Горизонтальный сплит
keymap("n", "<leader>se", "<C-w>=", opts) -- Выровнять сплиты
keymap("n", "<leader>sx", ":close<CR>", opts) -- Закрыть сплит

-- ===== NVIM-TREE =====
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts) -- Открыть/закрыть дерево
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts) -- Обновить дерево

-- ===== CLIPBOARD =====
keymap("v", "<leader>y", '"+y', opts) -- Копировать в system clipboard
keymap("n", "<leader>p", '"+p', opts) -- Вставить из system clipboard

-- ===== MISC =====
keymap("n", "<C-q>", ":bdelete<CR>", opts) -- Закрыть текущий буфер
keymap("n", "<leader>h", ":set hlsearch!<CR>", opts) -- Вкл/выкл подсветку поиска
