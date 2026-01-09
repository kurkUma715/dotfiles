-- nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup {
      update_cwd = true,
      respect_buf_cwd = true,
      view = {
        side = "left",
        width = 30,
      },
      renderer = {
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      actions = {
        open_file = {
            resize_window = true,
        },
    },
    }
  end,
}
