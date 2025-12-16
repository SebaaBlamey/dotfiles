return {
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	name = "kanagawa",
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			overrides = function(colors)
	-- 				return {
	-- 					LineNr = { fg = colors.palette.fujiGray },
	-- 					CursorLineNr = { fg = colors.palette.peach, bold = true },
	-- 				}
	-- 			end,
	-- 		})
	-- 		vim.cmd("colorscheme kanagawa-dragon")
	-- 	end,
	-- },
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	name = "ayu",
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			vim.cmd("colorscheme ayu-mirage"),
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({})
	-- 		vim.cmd("colorscheme catppuccin-mocha")
	-- 	end,
	-- },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			style = "dark",
	-- 			lualine = {
	-- 				transparent = true,
	-- 			},
	-- 		})
	-- 		require("onedark").load()
	-- 	end,
	-- },
}
