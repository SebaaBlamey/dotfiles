return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Aquí puedes agregar cualquier configuración adicional si la necesitas
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      {
        "ts",
        desc = "Start Terminal in split",
      },
      {
        "tv",
        desc = "Start Terminal in vsplit",
      },
      {
        "tf",
        desc = "Start Terminal in floating",
      },
    })
  end,
}
