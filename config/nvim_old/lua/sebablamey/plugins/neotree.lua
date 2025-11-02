return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
    config = function()
      require("neotree").setup({
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 10,
          side = "left",
          auto_resize = false,
          float = enable,
        },
        filesystem = {
          bind_to_cwd = false,
          hijack_netrw_behavior = "disabled",
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
          },
        },
      })
    end,
  },
}
