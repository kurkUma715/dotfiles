-- Автокоманды для LazyVim
vim.cmd([[autocmd BufEnter * silent! lcd %:p:h]])

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.json", "*.cs" },
  callback = function()
    local file = vim.fn.expand("%") -- текущий файл

    local ext = vim.fn.expand("%:e")
    if ext == "c" or ext == "cpp" then
      vim.cmd("w")
      vim.fn.system({ "clang-format", "-i", file })
    else
      vim.cmd("w")
      vim.fn.system({ "prettier", "--write", file })
    end

    vim.cmd("edit!")
  end,
})
