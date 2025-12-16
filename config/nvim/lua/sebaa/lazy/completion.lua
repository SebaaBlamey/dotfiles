local lspkind_symbols = nil

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"Kaiser-Yang/blink-cmp-avante",
			"giuxtaposition/blink-cmp-copilot",
		},
		version = "*",

		opts = {
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},

				trigger = {
					show_on_keyword = true,
					show_on_trigger_character = true,
					show_on_insert_on_trigger_character = true,
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					update_delay_ms = 50,
					treesitter_highlighting = false,
					window = {
						border = "rounded",
						max_width = 75,
						max_height = 12,
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
					cycle = {
						from_bottom = true,
						from_top = true,
					},
				},

				menu = {
					border = "rounded",
					max_height = 12,
					min_width = 25,
					scrollbar = true,
					scrolloff = 1,
					auto_show = true,

					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

					cmdline_position = function()
						local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
						return { vim.o.lines - height, 0 }
					end,

					draw = {
						padding = { 1, 1 },
						gap = 1,

						columns = {
							{ "kind_icon", gap = 1 },
							{ "label", "label_description", gap = 1 },
							{ "kind", gap = 1 },
							{ "source_name" },
						},

						components = {
							kind_icon = {
								text = function(item)
									if not lspkind_symbols then
										lspkind_symbols = require("lspkind").symbol_map
									end
									return (lspkind_symbols[item.kind] or "") .. " "
								end,
								highlight = function(item)
									return "BlinkCmpKind" .. item.kind
								end,
							},

							label = {
								text = function(item)
									return item.label
								end,
								highlight = "BlinkCmpLabel",
								width = { fill = true, max = 35 },
							},

							label_description = {
								text = function(item)
									if item.labelDetails and item.labelDetails.description then
										return " " .. item.labelDetails.description
									end
									return ""
								end,
								highlight = "BlinkCmpLabelDescription",
								width = { max = 25 },
							},

							kind = {
								text = function(item)
									return item.kind
								end,
								highlight = function(item)
									return "BlinkCmpKind" .. item.kind
								end,
							},

							source_name = {
								text = function(item)
									local source_icons = {
										lsp = "󰒋",
										path = "󰉋",
										snippets = "󰘧",
										buffer = "󰈙",
										cmdline = "󰆍",
									}
									return source_icons[item.source_name] or ""
								end,
								highlight = "BlinkCmpSource",
							},
						},
					},
				},
			},

			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = {
					function(cmp)
						-- Check if Copilot suggestion is visible first
						local ok, copilot = pcall(require, "copilot.suggestion")
						if ok and copilot.is_visible() then
							copilot.accept()
							return
						end
						
						if cmp.snippet_active() then
							return cmp.snippet_forward()
						else
							return cmp.select_next()
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.snippet_backward()
						else
							return cmp.select_prev()
						end
					end,
					"fallback",
				},

				["<C-j>"] = {
					function(cmp)
						if cmp.snippet_active() then
							cmp.snippet_forward()
						end
					end,
				},
				["<C-k>"] = {
					function(cmp)
						if cmp.snippet_active() then
							cmp.snippet_backward()
						end
					end,
				},

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},

			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},

			sources = {
				default = { "avante", "lsp", "snippets", "path", "buffer", "copilot" },

				per_filetype = {
					lua = { "lsp", "snippets", "path" },
					python = { "lsp", "snippets", "path" },
					javascript = { "lsp", "snippets", "path" },
					javascriptreact = { "lsp", "snippets", "path" },
					typescript = { "lsp", "snippets", "path" },
					typescriptreact = { "lsp", "snippets", "path" },
					go = { "lsp", "snippets", "path" },
				},

				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						enabled = true,
						min_keyword_length = 1,
						score_offset = 1000,
						max_items = 30,
						fallbacks = { "snippets" },
					},

					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 50,
						min_keyword_length = 1,
						max_items = 8,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = false,
						},
					},

					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = 900,
						min_keyword_length = 2,
						max_items = 15,
					},

					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 3,
						max_items = 5,
						score_offset = 10,
						opts = {
							get_bufnrs = function()
								local buf = vim.api.nvim_get_current_buf()
								local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
								if byte_size > 512 * 1024 then
									return {}
								end
								return { buf }
							end,
						},
					},
				},
			},

			cmdline = {
				enabled = true,
				sources = { "cmdline", "path" },
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)

			-------------------------------------------------------------------
			--  **HIGHLIGHTS AUTOMÁTICOS (SIN COLORES HARDCODEADOS)**
			-------------------------------------------------------------------
			local function setup_highlights()
				-- Heredar colores del colorscheme activo
				vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
				vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
				vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
				vim.api.nvim_set_hl(0, "BlinkCmpLabel", { link = "Normal" })
				vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
				vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "NonText" })

				-- Mapear kinds → grupos estándar del colorscheme
				local kind_to_group = {
					Text = "Normal",
					Method = "Function",
					Function = "Function",
					Constructor = "Special",
					Field = "Identifier",
					Variable = "Identifier",
					Class = "Type",
					Interface = "Type",
					Module = "Include",
					Property = "Identifier",
					Unit = "Number",
					Value = "Number",
					Enum = "Type",
					Keyword = "Keyword",
					Snippet = "Special",
					Color = "String",
					File = "Directory",
					Reference = "Special",
					Folder = "Directory",
					EnumMember = "Constant",
					Constant = "Constant",
					Struct = "Type",
					Event = "Type",
					Operator = "Operator",
					TypeParameter = "Type",
				}

				for kind, grp in pairs(kind_to_group) do
					vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { link = grp })
				end
			end

			setup_highlights()

			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("BlinkCmpHighlights", { clear = true }),
				callback = setup_highlights,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					vim.b.copilot_suggestion_hidden = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end,
	},

	-------------------------------------------------------------------
	-- LuaSnip
	-------------------------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")

			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-------------------------------------------------------------------
	-- Mason
	-------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"eslint",
					"pyright",
					"gopls",
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
				},
				automatic_installation = true,
			})
		end,
	},

	-------------------------------------------------------------------
	-- LSP CONFIG
	-------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 4 },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			local keymap_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
			vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
			vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, keymap_opts)

			local function eslint_fix_on_save(client, bufnr)
				if client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.code_action({
								context = { only = { "source.fixAll.eslint" } },
								apply = true,
							})
						end,
					})
				end
			end

			local lsp_servers = {
				{
					"ts_ls",
					{
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
						settings = {
							typescript = { inlayHints = { includeInlayFunctionLikeReturnTypeHints = true } },
							javascript = { inlayHints = { includeInlayFunctionLikeReturnTypeHints = true } },
						},
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
					},
				},

				{
					"eslint",
					{
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
						on_attach = eslint_fix_on_save,
					},
				},

				{
					"pyright",
					{
						filetypes = { "python" },
						settings = {
							python = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "workspace",
									useLibraryCodeForTypes = true,
								},
							},
						},
					},
				},

				{
					"gopls",
					{
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						settings = {
							gopls = {
								analyses = { unusedparams = true },
								staticcheck = true,
							},
						},
					},
				},

				{
					"lua_ls",
					{
						filetypes = { "lua" },
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					},
				},
			}

			for _, server in ipairs(lsp_servers) do
				local name, config = server[1], server[2] or {}
				config.capabilities = capabilities
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
			end
		end,
	},
}
