return {
  -- Цветовая схема
  { "folke/tokyonight.nvim" },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },

  -- Diagnostics
  { "folke/trouble.nvim", opts = { use_diagnostic_signs = true } },

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        pyright = {},
        tsserver = {},
        clangd = {
          cmd = {"clangd", "--compile-commands-dir=build" },
        },
        omnisharp = {
          cmd = { "/usr/bin/omnisharp" },
        },
        jsonls = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c", "cpp", "c_sharp", "bash", "html", "javascript",
        "json", "lua", "markdown", "python", "query", "regex",
        "tsx", "typescript", "vim", "yaml", "ini"
      },
    },
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        --"clangd", "omnisharp",
        "json-lsp", "efm",
        "stylua", "flake8", "shellcheck", "shfmt",
      },
    },
  },

  {
  "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, function() return "😄" end)
    end,
  },

  -- mini.starter
  --{
  --  "nvim-mini/mini.starter",
  --  config = function()
  --    require("mini.starter").setup({ evaluate_single = true })
  --  end,
  --},

  -- JSON extras
  { import = "lazyvim.plugins.extras.lang.json" },
}
