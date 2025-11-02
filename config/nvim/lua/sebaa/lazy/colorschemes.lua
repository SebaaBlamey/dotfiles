return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				overrides = function(colors)
					return {
						LineNr = { fg = colors.palette.fujiGray },
						CursorLineNr = { fg = colors.palette.peach, bold = true },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
