return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		version = "*",

		opts = {
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				accept = { auto_brackets = { enabled = true } },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 250,
					treesitter_highlighting = true,
					window = {
						border = "rounded",
						max_width = 80,
						max_height = 20,
					},
				},
				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
						auto_insert = function(ctx)
							return ctx.mode == "cmdline"
						end,
					},
					-- Cycle through completion items
					cycle = {
						from_bottom = true,
						from_top = true,
					},
				},
				menu = {
					border = "rounded",
					-- Change max items shown
					max_height = 15,
					-- Scrollbar options
					scrollbar = true,
					scrolloff = 2,

					-- Auto show/hide behavior
					auto_show = true,

					cmdline_position = function()
						if vim.g.ui_cmdline_pos ~= nil then
							local pos = vim.g.ui_cmdline_pos
							return { pos[1] - 1, pos[2] }
						end
						local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
						return { vim.o.lines - height, 0 }
					end,

					draw = {
						-- Add padding and alignment
						padding = 1,
						gap = 1,

						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
							{ "source_name" },
						},

						components = {
							kind_icon = {
								text = function(item)
									local kind = require("lspkind").symbol_map[item.kind] or ""
									return kind .. " "
								end,
								highlight = "CmpItemKind",
							},

							label = {
								text = function(item)
									return item.label
								end,
								highlight = "CmpItemAbbr",
							},

							label_description = {
								text = function(item)
									return item.labelDetails and item.labelDetails.description or ""
								end,
								highlight = "CmpItemAbbrDeprecated",
							},

							kind = {
								text = function(item)
									return "(" .. item.kind .. ")"
								end,
								highlight = "CmpItemKind",
							},

							source_name = {
								text = function(item)
									return "[" .. item.source_name .. "]"
								end,
								highlight = "Comment",
							},
						},

						-- Treesitter highlighting for completion items
						treesitter = { "lsp" },
					},
				},
			},
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = {
					function(cmp)
						return cmp.select_next()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						return cmp.select_prev()
					end,
					"snippet_backward",
					"fallback",
				},
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-up>"] = { "scroll_documentation_up", "fallback" },
				["<C-down>"] = { "scroll_documentation_down", "fallback" },
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						min_keyword_length = 2,
						score_offset = 0,
						max_items = 20,
					},
					path = {
						min_keyword_length = 0,
					},
					snippets = {
						min_keyword_length = 2,
					},
					buffer = {
						min_keyword_length = 5,
						max_items = 5,
					},
				},
			},
			cmdline = {
				sources = { "cmdline", "path" },
			},
		},
	},

	-- Rest of your config...
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "eslint" },
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure diagnostic display
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Keybindings for diagnostics
			vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })

			-- TypeScript/JavaScript
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				capabilities = capabilities,
			})

			-- ESLint
			vim.lsp.config("eslint", {
				cmd = { "vscode-eslint-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				capabilities = capabilities,
			})

			-- Enable the servers
			vim.lsp.enable({ "ts_ls", "eslint" })
		end,
	},
}
