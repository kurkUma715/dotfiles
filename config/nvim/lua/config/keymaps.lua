local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

keymap("i", "<C-q>", "<Esc>bi", opts)
keymap("i", "<C-e>", "<Esc>ea", opts)

keymap("i", "<C-d>", "<BS>", opts)

keymap("i", "<C-Delete>", "<Esc>dw", opts)

keymap("n", "<C-w>", "<C-w>h", opts)

keymap("n", "q", "b", opts)

keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

--keymap("i", "<C-q>", "<Esc><C-w>c", opts)

keymap("n", "<C-q>", ":bdelete<CR>", opts)

keymap("v", "<leader>y", '"+y', opts)
