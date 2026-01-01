return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"javascript",
					-- The five parsers below should always be installed
					"lua",
					"vim",
					"vimdoc",
					"c",
					"query",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "python", "c" }, -- these and some other langs don't work well
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("transparent").clear_prefix("NeoTree")
			require("neo-tree").setup({
				sources = {
					"filesystem",
					"git_status",
				},
				source_selector = {
					winbar = true,
					statusline = true,
				},
				filesystem = {
					commands = {
						avante_add_files = function(state)
							local node = state.tree:get_node()
							local filepath = node:get_id()
							local relative_path = require("avante.utils").relative_path(filepath)

							local sidebar = require("avante").get()

							local open = sidebar:is_open()
							-- ensure avante sidebar is open
							if not open then
								require("avante.api").ask()
								sidebar = require("avante").get()
							end

							sidebar.file_selector:add_selected_file(relative_path)

							-- remove neo tree buffer
							if not open then
								sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
							end
						end,
					},
					window = {
						mappings = {
							["oa"] = "avante_add_files",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-mini/mini.icons",
			"AndreM222/copilot-lualine",
		},
		config = function()
			require("lualine").setup({
				options = {
					component_separators = "",
					section_separators = { left = "", right = "" },
					globalstatus = true, -- if using laststatus=3
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "" },
							right_padding = 2,
							fmt = function(str)
								local mode_icons = {
									["NORMAL"] = "󰊠",
									["INSERT"] = "󰏫",
									["VISUAL"] = "󰒉",
									["V-LINE"] = "󰒉",
									["V-BLOCK"] = "󰒉",
									["REPLACE"] = "󰛔",
									["COMMAND"] = "󰘳",
									["TERMINAL"] = "",
									["SELECT"] = "󰒉",
									["S-LINE"] = "󰒉",
									["S-BLOCK"] = "󰒉",
								}
								return mode_icons[str] or str
							end,
						},
					},
					lualine_b = { "filename", "branch" },
					lualine_c = { "%=" },
					lualine_x = {
						{
							"copilot",
							symbols = {
								status = {
									icons = {
										enabled = " ",
										sleep = " ",
										disabled = " ",
										warning = " ",
										unknown = " ",
									},
									hl = {
										enabled = "#A3BE8C",
										sleep = "#60728A",
										disabled = "#4C566A",
										warning = "#EBCB8B",
										unknown = "#BF616A",
									},
								},
								spinners = "dots",
								spinner_color = "#6272A4",
							},
							show_colors = true,
							show_loading = true,
						},
						"diagnostics",
					},
					lualine_y = {
						"filetype",
						function()
							local current_line = vim.fn.line(".")
							local total_lines = vim.fn.line("$")
							local progress = current_line / total_lines
							local vertical_chars = {
								"󰂎",
								"󰁺",
								"󰁻",
								"󰁼",
								"󰁽",
								"󰁾",
								"󰁿",
								"󰂀",
								"󰂁",
								"󰂂",
								"󰁹",
							}
							local index = math.min(math.floor(progress * 11) + 1, 11)
							return vertical_chars[index]
						end,
					},
					lualine_z = {
						{
							"location",
							separator = { right = "" },
							left_padding = 2,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = "*",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 80,
				},
				symbol = "┃",
			})
		end,
	},
	-- {
	-- 	"sphamba/smear-cursor.nvim",
	-- 	opts = {},
	-- },
	{
		"xiyaowong/transparent.nvim",
	},
	-- lazy.nvim setup
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
					header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⠀⢀⠠⣀⠰⢠⠐⡈⠉⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⡌⠂⣅⣤⣬⢦⣬⡐⢡⠂⠀⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠄⡘⢠⡟⣽⢾⣹⡟⣼⡽⣦⡈⢀⠀⠀⢸⣿⠟⠋⠉⠉⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠠⠘⠄⣯⡽⣞⣯⢷⣹⢾⣽⢣⡗⡀⠠⠀⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠠⢉⢼⣳⣻⡽⣎⡷⣫⠷⣞⣭⡓⠤⠐⠀⠀⠀⡀⡀⠠⢤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠰⢁⢸⡷⣳⢻⣜⢷⣫⢟⣮⡓⣌⠳⢀⠢⣉⢦⡱⣐⠌⡄⣈⠙⠿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠈⡄⡿⣭⡳⣏⡾⣣⡟⢖⠱⠈⣤⢞⣣⢏⡖⢧⣙⠞⡴⢢⡑⠤⡈⠻⢿⣷⣤⡀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⢡⠐⠹⣧⢻⡜⡷⢍⡱⠊⣤⠻⣜⣚⢦⣛⡼⢣⡝⣎⢳⢣⡝⣲⣁⠎⡄⠻⣿⣿⣦⡀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡄⠈⢀⢩⠣⢜⡰⢊⠄⣼⡒⣟⣬⢳⡭⢶⣩⠗⣮⣙⢎⡳⡜⣥⢚⡖⣌⠆⡈⢿⣿⣿⡄⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⣈⠀⠀⠱⢊⠴⠉⣜⡲⣝⠮⣖⠯⣜⡳⢎⡽⡲⣍⡞⣱⡙⢦⢫⡔⣣⢎⡱⢀⠹⠋⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⠎⢀⡄⠊⠀⠉⠖⢸⡜⡵⣎⡻⢼⣙⢮⡝⠉⠀⠀⠀⠈⠁⠙⣎⠧⡜⣥⢚⡴⠁⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⡜⠀⠘⢡⣂⠑⠀⠄⣳⡚⡵⣎⠽⣣⢏⡞⠀⣾⠃⠀⠀⠀⠀⠈⠄⣛⠼⡰⣋⠄⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠂⡇⢌⡐⠴⣩⢏⡳⢄⢧⡹⠵⣎⠯⡵⣚⠀⢀⠀⡄⠤⢈⠀⠄⠀⢸⢈⡞⢥⢣⡀⠀⠀⠀⠀⢴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢧⢃⠤⡐⡏⠶⣩⠞⣭⠲⣭⢓⡮⣝⢲⢭⠀⢢⠑⡨⢐⠡⠒⡀⠀⣸⠰⣘⢣⠳⡜⡢⢄⢦⡑⡘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⢆⡣⢔⣣⢣⡑⢃⣋⠴⣌⠲⣋⠶⡩⢂⢯⣡⢀⠊⠔⣁⠊⠅⢄⣴⠣⠜⡤⢃⢻⡘⡵⢋⢦⠳⡄⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠠⡓⢎⡲⢥⢋⡳⣌⠳⣌⠳⣔⢲⠲⣍⠶⣡⢇⡏⣒⢒⡓⢚⢋⠦⡱⣉⠖⡩⢆⡝⡲⣍⢎⢧⣙⡘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⢉⢮⠱⣎⢣⡕⢎⡳⣌⠳⣌⢧⢫⠜⣎⠵⣊⢖⡡⢎⠴⣉⢎⠲⡱⣈⢎⡱⢪⡜⡱⣜⠪⣖⡡⠆⣿⣿⣿⣿⠿⠛⠉⠉⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠈⣑⠮⣱⢊⢧⢓⡬⢳⠜⡦⢋⡞⢬⡚⣥⢚⡴⣉⠖⡡⢎⠲⡑⡌⢦⢱⢣⡚⠵⣌⠳⢦⡙⠆⣹⣿⣿⣿⡀⠲⡏⠀⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢁⢲⠩⡖⣥⢋⡎⡞⣌⢣⠛⡬⢳⡘⣣⠕⣎⠵⡚⣬⠚⣕⢪⠵⣱⢊⢧⢋⡖⢭⠳⣌⡛⡴⣉⠇⢸⣿⣿⣿⣷⡄⠀⣸⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢁⡎⡥⢛⡴⢊⡵⢊⡵⢊⠶⣩⢔⡣⣜⡱⣚⠼⣸⠱⣆⠻⣌⠳⢎⡱⢎⢮⡱⢎⢣⢳⡘⡴⢣⠍⠎⠘⣿⣿⣿⡿⠁⣰⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⢠⡜⢣⡜⡜⡥⢎⠳⣌⠳⣌⢏⡚⡥⢎⡵⢢⡓⣥⢋⡖⢭⢲⡙⣬⡙⡎⡵⢊⠖⡱⢎⢣⢣⢎⡱⢣⡹⠈⣌⠪⡙⠛⠁⣴⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡿⠛⠉⡡⡌⠧⡜⢣⡜⢲⢱⢊⡳⢌⡳⢌⠶⣉⠶⣉⠖⢣⡹⢤⣋⡜⢎⡱⣚⢤⠓⡩⣐⢎⠮⡱⢎⢣⢣⢎⡱⢣⠅⡃⢌⢳⠩⡙⣰⣿⣿⣿⣿⣿⣿
]],
					keys = {},
					sections = {
						{ section = "header" },
						{
							pane = 2,
							section = "terminal",
							cmd = "colorscript -e square",
							height = 5,
							padding = 1,
						},
						{ section = "keys", gap = 1, padding = 1 },
						{
							pane = 2,
							icon = " ",
							title = "Recent Files",
							section = "recent_files",
							indent = 2,
							padding = 1,
						},
						{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
						{
							pane = 2,
							icon = " ",
							title = "Git Status",
							section = "terminal",
							enabled = vim.fn.isdirectory(".git") == 1,
							cmd = "hub status --short --branch --renames",
							height = 5,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						},
						{ section = "startup" },
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"norcalli/nvim-colorizer.lua",
		-- config = function()
		-- 	require("nvim-highlight-colors").setup({})
		-- end,
	},
}
