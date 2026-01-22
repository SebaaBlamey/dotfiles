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
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	name = "ayu",
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			-- vim.cmd("colorscheme ayu-mirage"),
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({})
	-- 		-- vim.cmd("colorscheme catppuccin-mocha")
	-- 	end,
	-- },
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- },
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
	-- 		-- require("onedark").load()
	-- 	end,
	-- },
	-- { "EdenEast/nightfox.nvim" },
	-- {
	-- 	"oxfist/night-owl.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		require("night-owl").setup()
	-- 		-- vim.cmd.colorscheme("night-owl")
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	-- { "datsfilipe/vesper.nvim" },
	-- {
	-- 	"serhez/teide.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	-- {
	-- 	"baliestri/aura-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function(plugin)
	-- 		vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
	-- 		vim.cmd([[colorscheme aura-dark]])
	-- 	end,
	-- },
	-- {
	-- 	"cpplain/flexoki.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	-- {
	-- 	"roerohan/orng.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("orng").setup({
	-- 			variant = "dark", -- "dark" or "light"
	-- 			transparent = false,
	-- 			italic_comment = false,
	-- 		})
	-- 		vim.cmd("colorscheme orng")
	-- 	end,
	-- },
}
