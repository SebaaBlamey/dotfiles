return {
	-- autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},
	{
		-- surround
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-mini/mini.icons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "nvim-mini/mini.icons" },
		opts = {},
		config = function()
			require("fzf-lua").setup({
				vim.keymap.set("n", "<leader>uC", function()
					local fzf = require("fzf-lua")
					fzf.colorschemes({
						actions = {
							["default"] = function(selected)
								local colorscheme = selected[1]
								vim.cmd.colorscheme(colorscheme)

								local config_file = vim.fn.stdpath("config") .. "/lua/sebaa/settings/colorscheme.lua"

								local content = string.format('return {\n  colorscheme = "%s",\n}\n', colorscheme)

								local file = io.open(config_file, "w")
								if file then
									file:write(content)
									file:close()
									print("Colorscheme guardado en: " .. config_file)
								else
									print("Error: No se pudo guardar el colorscheme")
								end
							end,
						},
					})
				end, { desc = "Colorscheme with preview and save" }),
			})
			require("fzf-lua").register_ui_select()
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			-- vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				lua = { "stylua" }, -- optional: format Lua code with stylua
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			-- Register your custom key descriptions here
			registers = {
				["<leader>"] = {
					e = "Toggle Neotree",
					["<leader>"] = "Find files (FzfLua)",
					fw = "Live grep (FzfLua)",
					fb = "Buffers list (FzfLua)",
				},
				["<C-.>"] = "Code Actions (actions-preview)",
				["<C-a>"] = "Select All",
				["<C-s>"] = "Save All",
				["<C-p>"] = {
					d = "Split Down",
					r = "Split Right",
				},
				["<C-q>"] = "Close Current Tab",
				["<C-t>"] = {
					d = "Terminal Below (split)",
					r = "Terminal Right (vsplit)",
				},
				["g"] = {
					I = "Show LSP Hover",
				},
				["<C-h>"] = "Move Window Left",
				["<C-l>"] = "Move Window Right",
				["<C-j>"] = "Move Window Down",
				["<C-k>"] = "Move Window Up",
			},
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
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				ui = {
					code_action = "",
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-mini/mini.icons", -- optional
		},
	},
	-- nvim v0.8.0
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	-- markdown preview
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				enabled = true,
				sign = true,
				style = "full",
				icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
				left_pad = 1,
			},
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
				right_pad = 1,
				highlight = "render-markdownBullet",
			},
		},
	},
}
