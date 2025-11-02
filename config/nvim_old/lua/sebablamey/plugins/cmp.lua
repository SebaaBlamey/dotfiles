return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		"rafamadriz/friendly-snippets", -- collection of snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")

		luasnip.config.setup({})
		lspkind.init({
			symbol_map = {
				Supermaven = "󱚝",
			},
		})

		-- Load friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "html-css" },
				{ name = "supermaven" },
			}),
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:Pmenu,FloatBorder:PMenu,Search:None",
					col_offset = 1,
					side_padding = 0,
				},
				documentation = {
					border = "rounded",
				},
			},
			formatting = {
				fields = { "kind", "abbr" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "

					return kind
				end,
			},
		})

		vim.cmd([[
			set completeopt=menuone,noinsert,noselect
			highlight! default link CmpItemKind CmpItemMenuDefault
		]])
	end,
}
