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
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "nvim-mini/mini.icons" },
		opts = {},
		config = function()
			require("fzf-lua").setup()
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
}
