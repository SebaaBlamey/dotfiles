return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = { "nvim-lua/plenary.nvim", "olacin/telescope-cc.nvim" },
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				conventional_commits = {
					theme = "ivy",
					action = function(entry)
						vim.print(entry)
					end,
					include_body_and_footer = true,
				},
			},
		})
		telescope.load_extension("conventional_commits")
	end,
}
