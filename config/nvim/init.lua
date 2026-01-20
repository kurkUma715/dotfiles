--init.lua

-- ===============================
-- Packer bootstrap
-- ===============================
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- ===============================
-- Плагины
-- ===============================
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- сам packer
    use 'nvim-tree/nvim-tree.lua' -- файловый проводник
    use 'nvim-tree/nvim-web-devicons' -- иконки для проводника

    -- Автодополнение и сниппеты
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    
    -- Подсветка синтаксиса (ВАЖНО!)
    use 'nvim-treesitter/nvim-treesitter' -- деревья для лучшей подсветки
    use 'nvim-treesitter/nvim-treesitter-context' -- контекст текущей функции

    -- LSP
    use 'neovim/nvim-lspconfig' -- конфигурация LSP серверов
    use 'williamboman/mason.nvim' -- менеджер LSP серверов
    use 'williamboman/mason-lspconfig.nvim' -- мост между mason и lspconfig

    -- Цветовая схема
    use 'navarasu/onedark.nvim' -- популярная цветовая схема

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- ===============================
-- Настройка подсветки и цветовой схемы
-- =========================------
require('onedark').setup({
    style = 'dark',
    transparent = false,
    term_colors = true,
})
require('onedark').load()

-- Treesitter для улучшенной подсветки
require('nvim-treesitter').setup({
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

-- ===============================
-- Настройка LSP
-- ===============================
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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


-- ===============================
-- NvimTree setup
-- ===============================
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
        highlight_git = true,
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            }
        }
    }
})

-- ===============================
-- Настройка nvim-cmp (автодополнение
-- ===============================
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
})

-- ===============================
-- Основные настройки
-- ===============================
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.syntax = "enable" -- Включение синтаксиса
vim.opt.clipboard = "unnamedplus"


-- Включение подсветки поиска
vim.o.hlsearch = true
vim.o.incsearch = true

-- Включение подсветки парных скобок
vim.o.showmatch = true
vim.o.matchtime = 2

-- Включение цветов терминала
vim.cmd('colorscheme onedark')

-- Автоматическое определение типа файла
vim.cmd('filetype plugin indent on')

-- ===============================
-- Keymaps
-- ===============================
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Быстрый выход из insert
keymap("i", "jk", "<Esc>", opts)

-- Центрировать экран
keymap("n", "zz", "zz", opts)

-- Поиск и замена
keymap("n", "<leader>s", ":%s//g<Left><Left>", opts)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)


keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)



-- Навигация между окнами
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- NvimTree
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

-- Закрытие буфера
keymap("n", "<C-q>", ":bdelete<CR>", opts)

-- Копирование в системный буфер
keymap("v", "<leader>y", '"+y', opts)

-- Включение/выключение подсветки поиска
keymap("n", "<leader>h", ":set hlsearch!<CR>", opts)
